Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270691AbRHJX4d>; Fri, 10 Aug 2001 19:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270692AbRHJX41>; Fri, 10 Aug 2001 19:56:27 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:61449 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S270691AbRHJX4J>; Fri, 10 Aug 2001 19:56:09 -0400
Message-ID: <005a01c121f8$8371bdc0$bef7020a@mammon>
From: "Jeremy Linton" <jlinton@interactivesi.com>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, "Rik van Riel" <riel@conectiva.com.br>
Subject: [BUG][PATCH] in sys_swapoff() path 
Date: Fri, 10 Aug 2001 18:59:35 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm resending this patch because it apparently went to /dev/null last time I
sent it. It is against 2.4.7p6 because it is a couple of weeks old, and I'm
working on other stuff now. I've also found a nice easy way to duplicate the
problems it fixes. Create two swap partitions, swapon them. Write or use a
program that causes extensive swapfile thrashing. Then swapoff the swap
partition that has the most used space. Make sure the remaining swap
partition has enough space to back all the userspace that is being
swapoff'ed. Watch the errors and processes get killed.

Now the original text.

There are some lock problems with the sys_swapoff call when the VM is under
load on MP boxes. These problems usually result a number of messages like
'VM: Undead swap entry XXXXX' and 'Unused swap offset entry in swap_dup
XXXXXX' being thrown while the machine is swapoff'ing. Its really a lock
problem but short of making pretty significant changes to fix the problem
and slowing the machine down and possibly breaking something in 2.4 I band
aided it. I think these problems have been here for a while but the kernel
lock and the resulting 'lockup' during swapoff kept them from happening as
frequently. The addition of the schedule call in try_to_unuse() causes the
bug to appear with a lot higher frequency. This problem is real, it needs to
be fixed one way or the other, I made two changes to solve the symptoms one
in try_to_unuse() where i don't reset the swap_map on undead swap entries.
This fixes all the problems but the problem in swap_dup which results in
processes getting killed. This I fixed by checking to see if the page
appeared while the locks were dropped in do_swap_page(). If the pte appeared
I just bail from do_swap_page and let the rest of the system fix the page up
(possibly on another fault) if needed.

The bug fix is the really important part of this patch. The rest of the
patch is a conservative method for giving try_to_unuse() a significant
performance improvement without changing how it functions. That part of this
patch provides roughly a 3x performance improvement to try_to_unuse(). It
achieves this by scanning the whole swap_map linearly, instead of constantly
rescanning previous pages it just scanned, before it tries to find a new
page. It concludes victory when it manages to make a whole scan of of the
swap_map without finding any used entries. On my main test box, swapoff
takes a little over 3 minutes to complete against 2.4.4. With this patch it
takes about 45 seconds.


jlinton


--- linux-2.4.7-pre6Orig/mm/swapfile.c Mon Jul 16 23:22:57 2001
+++ linux/mm/swapfile.c Wed Jul 18 20:58:41 2001
@@ -329,6 +329,54 @@
 }

 /*
+ * this is called when we find a page in the swap list
+ * all the locks have been dropped at this point which
+ * isn't a problem because we rescan the swap map
+ * and we _don't_ clear the refrence count if for
+ * some reason it isn't 0
+ */
+
+static inline int free_found_swap_entry(unsigned int type, int i)
+{
+ struct task_struct *p;
+ struct page *page;
+ swp_entry_t entry;
+
+ entry = SWP_ENTRY(type, i);
+
+ /*
+  * Get a page for the entry, using the existing swap
+  * cache page if there is one.  Otherwise, get a clean
+  * page and read the swap into it.
+  */
+ page = read_swap_cache_async(entry);
+ if (!page) {
+  swap_free(entry);
+  return -ENOMEM;
+ }
+ lock_page(page);
+ if (PageSwapCache(page))
+  delete_from_swap_cache_nolock(page);
+ UnlockPage(page);
+ read_lock(&tasklist_lock);
+ for_each_task(p)
+  unuse_process(p->mm, entry, page);
+ read_unlock(&tasklist_lock);
+ shmem_unuse(entry, page);
+ /*
+  * Now get rid of the extra reference to the temporary
+  * page we've been using.
+  */
+ page_cache_release(page);
+ /*
+  * Check for and clear any overflowed swap map counts.
+  */
+ swap_free(entry);
+ return 0;
+}
+
+
+/*
  * We completely avoid races by reading each swap page in advance,
  * and then search for the process using it.  All the necessary
  * page table adjustments can then be made atomically.
@@ -336,25 +384,16 @@
 static int try_to_unuse(unsigned int type)
 {
  struct swap_info_struct * si = &swap_info[type];
- struct task_struct *p;
- struct page *page;
- swp_entry_t entry;
  int i;
+ int ret,foundpage=1;

- while (1) {
+ while (foundpage) {
   /*
    * The algorithm is inefficient but seldomly used
-   * and probably not worth fixing.
    *
-   * Make sure that we aren't completely killing
-   * interactive performance.
-   */
-  if (current->need_resched)
-   schedule();
-
-  /*
    * Find a swap page in use and read it in.
    */
+  foundpage=0;
   swap_device_lock(si);
   for (i = 1; i < si->max ; i++) {
    if (si->swap_map[i] > 0 && si->swap_map[i] != SWAP_MAP_BAD) {
@@ -364,53 +403,56 @@
      * to read in the page - this prevents warning
      * messages from rw_swap_page_base.
      */
+    foundpage=1;
     if (si->swap_map[i] != SWAP_MAP_MAX)
      si->swap_map[i]++;
     swap_device_unlock(si);
-    goto found_entry;
-   }
-  }
-  swap_device_unlock(si);
-  break;
-
- found_entry:
-  entry = SWP_ENTRY(type, i);
+    ret=free_found_swap_entry(type,i);
+    if (ret) {
+      return ret;
+    }
+    /*
+     * we pick up the swap_list_lock() to guard the nr_swap_pages,
+     * si->swap_map[] should only be changed if it is SWAP_MAP_MAX
+     * otherwise ugly stuff can happen with other people who are in
+     * the middle of a swap operation to this device. This kind of
+     * operation can sometimes be detected with the undead swap
+     * check. Don't worry about these 'undead' entries for now
+     * they will be caught the next time though the top loop.
+     * Do worry, about the weak locking that allows this to happen
+     * because if it happens to a page that is SWAP_MAP_MAX
+     * then bad stuff can happen.
+     */
+    swap_list_lock();
+    swap_device_lock(si);
+    if (si->swap_map[i] > 0) {
+     /* normally this would just kill the swap page if
+      * it still existed, it appears though that the locks
+      * are a little fuzzy
+      */
+     if (si->swap_map[i] != SWAP_MAP_MAX) {
+      printk("VM: Undead swap entry %08lx\n",
+             SWP_ENTRY(type, i).val);
+     }
+     else {
+      nr_swap_pages++;
+      si->swap_map[i] = 0;
+     }
+    }
+    swap_device_unlock(si);
+    swap_list_unlock();

-  /* Get a page for the entry, using the existing swap
-                   cache page if there is one.  Otherwise, get a clean
-                   page and read the swap into it. */
-  page = read_swap_cache_async(entry);
-  if (!page) {
-   swap_free(entry);
-     return -ENOMEM;
-  }
-  lock_page(page);
-  if (PageSwapCache(page))
-   delete_from_swap_cache_nolock(page);
-  UnlockPage(page);
-  read_lock(&tasklist_lock);
-  for_each_task(p)
-   unuse_process(p->mm, entry, page);
-  read_unlock(&tasklist_lock);
-  shmem_unuse(entry, page);
-  /* Now get rid of the extra reference to the temporary
-                   page we've been using. */
-  page_cache_release(page);
-  /*
-   * Check for and clear any overflowed swap map counts.
-   */
-  swap_free(entry);
-  swap_list_lock();
-  swap_device_lock(si);
-  if (si->swap_map[i] > 0) {
-   if (si->swap_map[i] != SWAP_MAP_MAX)
-    printk("VM: Undead swap entry %08lx\n",
-        entry.val);
-   nr_swap_pages++;
-   si->swap_map[i] = 0;
+    /*
+     * This lock stuff is ulgy!
+     * Make sure that we aren't completely killing
+     * interactive performance.
+     */
+    if (current->need_resched)
+     schedule();
+    swap_device_lock(si);
+   }
   }
   swap_device_unlock(si);
-  swap_list_unlock();
  }
  return 0;
 }
--- linux-2.4.7-pre6Orig/mm/memory.c Mon Jul 16 23:22:57 2001
+++ linux/mm/memory.c Wed Jul 18 20:22:36 2001
@@ -1105,7 +1105,16 @@
   page = read_swap_cache_async(entry);
   unlock_kernel();
   if (!page) {
+   /*
+    * sometimes this fails because the page got read in by
+    * swap_off, check to see if that is what happend before we
+    * do bad things to this poor process, its still possible that
+    * this page will fault again.
+    */
    spin_lock(&mm->page_table_lock);
+   if (pte_present(*page_table)) {
+    return 1;
+   }
    return -1;
   }
  }





begin 666 Linux-2.4.7p6-SwapPatches
M+2TM(&QI;G5X+3(N-"XW+7!R939/<FEG+VUM+W-W87!F:6QE+F,)36]N($IU
M;" Q-B R,SHR,CHU-R R,# Q"BLK*R!L:6YU>"]M;2]S=V%P9FEL92YC"5=E
M9"!*=6P@,3@@,C Z-3@Z-#$@,C P,0I 0" M,S(Y+#8@*S,R.2PU-"! 0 H@
M?0H@"B O*@HK("H@=&AI<R!I<R!C86QL960@=VAE;B!W92!F:6YD(&$@<&%G
M92!I;B!T:&4@<W=A<"!L:7-T"BL@*B!A;&P@=&AE(&QO8VMS(&AA=F4@8F5E
M;B!D<F]P<&5D(&%T('1H:7,@<&]I;G0@=VAI8V@**R J(&ES;B=T(&$@<')O
M8FQE;2!B96-A=7-E('=E(')E<V-A;B!T:&4@<W=A<"!M87 **R J(&%N9"!W
M92!?9&]N)W1?(&-L96%R('1H92!R969R96YC92!C;W5N="!I9B!F;W(@"BL@
M*B!S;VUE(')E87-O;B!I="!I<VXG=" P"BL@*B\**R @( HK<W1A=&EC(&EN
M;&EN92!I;G0@9G)E95]F;W5N9%]S=V%P7V5N=')Y*'5N<VEG;F5D(&EN="!T
M>7!E+"!I;G0@:2D**WL**PES=')U8W0@=&%S:U]S=')U8W0@*G ["BL)<W1R
M=6-T('!A9V4@*G!A9V4["BL)<W=P7V5N=')Y7W0@96YT<GD["BL**PEE;G1R
M>2 ](%-74%]%3E1262AT>7!E+"!I*3L**PHK"2\J( HK"2 J($=E="!A('!A
M9V4@9F]R('1H92!E;G1R>2P@=7-I;F<@=&AE(&5X:7-T:6YG('-W87 **PD@
M*B!C86-H92!P86=E(&EF('1H97)E(&ES(&]N92X@($]T:&5R=VES92P@9V5T
M(&$@8VQE86X**PD@*B!P86=E(&%N9"!R96%D('1H92!S=V%P(&EN=&\@:70N
M( HK"2 J+PHK"7!A9V4@/2!R96%D7W-W87!?8V%C:&5?87-Y;F,H96YT<GDI
M.PHK"6EF("@A<&%G92D@>PHK"0ES=V%P7V9R964H96YT<GDI.PHK"0ER971U
M<FX@+45.3TU%33L**PE]"BL);&]C:U]P86=E*'!A9V4I.PHK"6EF("A086=E
M4W=A<$-A8VAE*'!A9V4I*0HK"0ED96QE=&5?9G)O;5]S=V%P7V-A8VAE7VYO
M;&]C:RAP86=E*3L**PE5;FQO8VM086=E*'!A9V4I.PHK"7)E861?;&]C:R@F
M=&%S:VQI<W1?;&]C:RD["BL)9F]R7V5A8VA?=&%S:RAP*0HK"0EU;G5S95]P
M<F]C97-S*' M/FUM+"!E;G1R>2P@<&%G92D["BL)<F5A9%]U;FQO8VLH)G1A
M<VML:7-T7VQO8VLI.PHK"7-H;65M7W5N=7-E*&5N=')Y+"!P86=E*3L**PDO
M*B **PD@*B!.;W<@9V5T(')I9"!O9B!T:&4@97AT<F$@<F5F97)E;F-E('1O
M('1H92!T96UP;W)A<GD**PD@*B!P86=E('=E)W9E(&)E96X@=7-I;F<N( HK
M"2 J+PHK"7!A9V5?8V%C:&5?<F5L96%S92AP86=E*3L**PDO*@HK"2 J($-H
M96-K(&9O<B!A;F0@8VQE87(@86YY(&]V97)F;&]W960@<W=A<"!M87 @8V]U
M;G1S+@HK"2 J+PHK"7-W87!?9G)E92AE;G1R>2D["BL)<F5T=7)N(# ["BM]
M"BL**PHK+RH*(" J(%=E(&-O;7!L971E;'D@879O:60@<F%C97,@8GD@<F5A
M9&EN9R!E86-H('-W87 @<&%G92!I;B!A9'9A;F-E+ H@("H@86YD('1H96X@
M<V5A<F-H(&9O<B!T:&4@<')O8V5S<R!U<VEN9R!I="X@($%L;"!T:&4@;F5C
M97-S87)Y"B @*B!P86=E('1A8FQE(&%D:G5S=&UE;G1S(&-A;B!T:&5N(&)E
M(&UA9&4@871O;6EC86QL>2X*0$ @+3,S-BPR-2 K,S@T+#$V($! "B!S=&%T
M:6,@:6YT('1R>5]T;U]U;G5S92AU;G-I9VYE9"!I;G0@='EP92D*('L*( ES
M=')U8W0@<W=A<%]I;F9O7W-T<G5C=" J('-I(#T@)G-W87!?:6YF;UMT>7!E
M73L*+0ES=')U8W0@=&%S:U]S=')U8W0@*G ["BT)<W1R=6-T('!A9V4@*G!A
M9V4["BT)<W=P7V5N=')Y7W0@96YT<GD["B ):6YT(&D["BL):6YT(')E="QF
M;W5N9'!A9V4],3L*( HM"7=H:6QE("@Q*2!["BL)=VAI;&4@*&9O=6YD<&%G
M92D@>PH@"0DO*@H@"0D@*B!4:&4@86QG;W)I=&AM(&ES(&EN969F:6-I96YT
M(&)U="!S96QD;VUL>2!U<V5D"BT)"2 J(&%N9"!P<F]B86)L>2!N;W0@=V]R
M=&@@9FEX:6YG+@H@"0D@*@HM"0D@*B!-86ME('-U<F4@=&AA="!W92!A<F5N
M)W0@8V]M<&QE=&5L>2!K:6QL:6YG"BT)"2 J(&EN=&5R86-T:79E('!E<F9O
M<FUA;F-E+@HM"0D@*B\*+0D):68@*&-U<G)E;G0M/FYE961?<F5S8VAE9"D*
M+0D)"7-C:&5D=6QE*"D["BT)"0D*+0D)+RH*( D)("H@1FEN9"!A('-W87 @
M<&%G92!I;B!U<V4@86YD(')E860@:70@:6XN"B )"2 J+PHK"0EF;W5N9'!A
M9V4],#L*( D)<W=A<%]D979I8V5?;&]C:RAS:2D["B )"69O<B H:2 ](#$[
M(&D@/"!S:2T^;6%X(#L@:2LK*2!["B )"0EI9B H<VDM/G-W87!?;6%P6VE=
M(#X@," F)B!S:2T^<W=A<%]M87!;:5T@(3T@4U=!4%]-05!?0D%$*2!["D! 
M("TS-C0L-3,@*S0P,RPU-B! 0 H@"0D)"2 J('1O(')E860@:6X@=&AE('!A
M9V4@+2!T:&ES('!R979E;G1S('=A<FYI;F<*( D)"0D@*B!M97-S86=E<R!F
M<F]M(')W7W-W87!?<&%G95]B87-E+@H@"0D)"2 J+PHK"0D)"69O=6YD<&%G
M93TQ.PH@"0D)"6EF("AS:2T^<W=A<%]M87!;:5T@(3T@4U=!4%]-05!?34%8
M*0H@"0D)"0ES:2T^<W=A<%]M87!;:5TK*SL*( D)"0ES=V%P7V1E=FEC95]U
M;FQO8VLH<VDI.PHM"0D)"6=O=&\@9F]U;F1?96YT<GD["BT)"0E]"BT)"7T*
M+0D)<W=A<%]D979I8V5?=6YL;V-K*'-I*3L*+0D)8G)E86L["BT*+0EF;W5N
M9%]E;G1R>3H*+0D)96YT<GD@/2!35U!?14Y44EDH='EP92P@:2D["BL)"0D)
M<F5T/69R965?9F]U;F1?<W=A<%]E;G1R>2AT>7!E+&DI.PHK"0D)"6EF("AR
M970I('L**PD)"0D@(')E='5R;B!R970["BL)"0D)?0HK"0D)"2\J"BL)"0D)
M("H@=V4@<&EC:R!U<"!T:&4@<W=A<%]L:7-T7VQO8VLH*2!T;R!G=6%R9"!T
M:&4@;G)?<W=A<%]P86=E<RP**PD)"0D@*B!S:2T^<W=A<%]M87!;72!S:&]U
M;&0@;VYL>2!B92!C:&%N9V5D(&EF(&ET(&ES(%-705!?34%07TU!6 HK"0D)
M"2 J(&]T:&5R=VES92!U9VQY('-T=69F(&-A;B!H87!P96X@=VET:"!O=&AE
M<B!P96]P;&4@=VAO(&%R92!I;@HK"0D)"2 J('1H92!M:61D;&4@;V8@82!S
M=V%P(&]P97)A=&EO;B!T;R!T:&ES(&1E=FEC92X@5&AI<R!K:6YD(&]F"BL)
M"0D)("H@;W!E<F%T:6]N(&-A;B!S;VUE=&EM97,@8F4@9&5T96-T960@=VET
M:"!T:&4@=6YD96%D('-W87 @"BL)"0D)("H@8VAE8VLN($1O;B=T('=O<G)Y
M(&%B;W5T('1H97-E("=U;F1E860G(&5N=')I97,@9F]R(&YO=PHK"0D)"2 J
M('1H97D@=VEL;"!B92!C875G:'0@=&AE(&YE>'0@=&EM92!T:&]U9V@@=&AE
M('1O<"!L;V]P+@HK"0D)"2 J($1O('=O<G)Y+"!A8F]U="!T:&4@=V5A:R!L
M;V-K:6YG('1H870@86QL;W=S('1H:7,@=&\@:&%P<&5N"BL)"0D)("H@8F5C
M875S92!I9B!I="!H87!P96YS('1O(&$@<&%G92!T:&%T(&ES(%-705!?34%0
M7TU!6 HK"0D)"2 J('1H96X@8F%D('-T=69F(&-A;B!H87!P96XN"BL)"0D)
M("HO"BL)"0D)<W=A<%]L:7-T7VQO8VLH*3L**PD)"0ES=V%P7V1E=FEC95]L
M;V-K*'-I*3L**PD)"0EI9B H<VDM/G-W87!?;6%P6VE=(#X@,"D@>PHK"0D)
M"0DO*B!N;W)M86QL>2!T:&ES('=O=6QD(&IU<W0@:VEL;"!T:&4@<W=A<"!P
M86=E(&EF"BL)"0D)"2 J(&ET('-T:6QL(&5X:7-T960L(&ET(&%P<&5A<G,@
M=&AO=6=H('1H870@=&AE(&QO8VMS( HK"0D)"0D@*B!A<F4@82!L:71T;&4@
M9G5Z>GD**PD)"0D)("HO"BL)"0D)"6EF("AS:2T^<W=A<%]M87!;:5T@(3T@
M4U=!4%]-05!?34%8*2!["BL)"0D)"0EP<FEN=&LH(E9-.B!5;F1E860@<W=A
M<"!E;G1R>2 E,#AL>%QN(BP@"BL)"0D)"0D@(" @(" @4U=07T5.5%)9*'1Y
M<&4L(&DI+G9A;"D["BL)"0D)"7T**PD)"0D)96QS92!["BL)"0D)"0EN<E]S
M=V%P7W!A9V5S*RL["BL)"0D)"0ES:2T^<W=A<%]M87!;:5T@/2 P.PHK"0D)
M"0E]"BL)"0D)?0HK"0D)"7-W87!?9&5V:6-E7W5N;&]C:RAS:2D["BL)"0D)
M<W=A<%]L:7-T7W5N;&]C:R@I.PH@"BT)"2\J($=E="!A('!A9V4@9F]R('1H
M92!E;G1R>2P@=7-I;F<@=&AE(&5X:7-T:6YG('-W87 *+2 @(" @(" @(" @
M(" @(" @("!C86-H92!P86=E(&EF('1H97)E(&ES(&]N92X@($]T:&5R=VES
M92P@9V5T(&$@8VQE86X*+2 @(" @(" @(" @(" @(" @("!P86=E(&%N9"!R
M96%D('1H92!S=V%P(&EN=&\@:70N("HO"BT)"7!A9V4@/2!R96%D7W-W87!?
M8V%C:&5?87-Y;F,H96YT<GDI.PHM"0EI9B H(7!A9V4I('L*+0D)"7-W87!?
M9G)E92AE;G1R>2D["BT@( D)"7)E='5R;B M14Y/345-.PHM"0E]"BT)"6QO
M8VM?<&%G92AP86=E*3L*+0D):68@*%!A9V53=V%P0V%C:&4H<&%G92DI"BT)
M"0ED96QE=&5?9G)O;5]S=V%P7V-A8VAE7VYO;&]C:RAP86=E*3L*+0D)56YL
M;V-K4&%G92AP86=E*3L*+0D)<F5A9%]L;V-K*"9T87-K;&ES=%]L;V-K*3L*
M+0D)9F]R7V5A8VA?=&%S:RAP*0HM"0D)=6YU<V5?<')O8V5S<RAP+3YM;2P@
M96YT<GDL('!A9V4I.PHM"0ER96%D7W5N;&]C:R@F=&%S:VQI<W1?;&]C:RD[
M"BT)"7-H;65M7W5N=7-E*&5N=')Y+"!P86=E*3L*+0D)+RH@3F]W(&=E="!R
M:60@;V8@=&AE(&5X=')A(')E9F5R96YC92!T;R!T:&4@=&5M<&]R87)Y"BT@
M(" @(" @(" @(" @(" @(" @<&%G92!W92=V92!B965N('5S:6YG+B J+PHM
M"0EP86=E7V-A8VAE7W)E;&5A<V4H<&%G92D["BT)"2\J"BT)"2 J($-H96-K
M(&9O<B!A;F0@8VQE87(@86YY(&]V97)F;&]W960@<W=A<"!M87 @8V]U;G1S
M+@HM"0D@*B\*+0D)<W=A<%]F<F5E*&5N=')Y*3L*+0D)<W=A<%]L:7-T7VQO
M8VLH*3L*+0D)<W=A<%]D979I8V5?;&]C:RAS:2D["BT)"6EF("AS:2T^<W=A
M<%]M87!;:5T@/B P*2!["BT)"0EI9B H<VDM/G-W87!?;6%P6VE=("$](%-7
M05!?34%07TU!6"D*+0D)"0EP<FEN=&LH(E9-.B!5;F1E860@<W=A<"!E;G1R
M>2 E,#AL>%QN(BP@"BT)"0D)"0D)"65N=')Y+G9A;"D["BT)"0EN<E]S=V%P
M7W!A9V5S*RL["BT)"0ES:2T^<W=A<%]M87!;:5T@/2 P.PHK"0D)"2\J"BL)
M"0D)("H@5&AI<R!L;V-K('-T=69F(&ES('5L9WDA"BL)"0D)("H@36%K92!S
M=7)E('1H870@=V4@87)E;B=T(&-O;7!L971E;'D@:VEL;&EN9PHK"0D)"2 J
M(&EN=&5R86-T:79E('!E<F9O<FUA;F-E+@HK"0D)"2 J+PHK"0D)"6EF("AC
M=7)R96YT+3YN965D7W)E<V-H960I"BL)"0D)"7-C:&5D=6QE*"D["BL)"0D)
M<W=A<%]D979I8V5?;&]C:RAS:2D[( HK"0D)?0H@"0E]"B )"7-W87!?9&5V
M:6-E7W5N;&]C:RAS:2D["BT)"7-W87!?;&ES=%]U;FQO8VLH*3L*( E]"B )
M<F5T=7)N(# ["B!]"BTM+2!L:6YU>"TR+C0N-RUP<F4V3W)I9R]M;2]M96UO
M<GDN8PE-;VX@2G5L(#$V(#(S.C(R.C4W(#(P,#$**RLK(&QI;G5X+VUM+VUE
M;6]R>2YC"5=E9"!*=6P@,3@@,C Z,C(Z,S8@,C P,0I 0" M,3$P-2PW("LQ
M,3 U+#$V($! "B )"7!A9V4@/2!R96%D7W-W87!?8V%C:&5?87-Y;F,H96YT
M<GDI.PH@"0EU;FQO8VM?:V5R;F5L*"D["B )"6EF("@A<&%G92D@>PHK"0D)
M+RH**PD)"2 J('-O;65T:6UE<R!T:&ES(&9A:6QS(&)E8V%U<V4@=&AE('!A
M9V4@9V]T(')E860@:6X@8GD**PD)"2 J('-W87!?;V9F+"!C:&5C:R!T;R!S
M964@:68@=&AA="!I<R!W:&%T(&AA<'!E;F0@8F5F;W)E('=E( HK"0D)("H@
M9&\@8F%D('1H:6YG<R!T;R!T:&ES('!O;W(@<')O8V5S<RP@:71S('-T:6QL
M('!O<W-I8FQE('1H870**PD)"2 J('1H:7,@<&%G92!W:6QL(&9A=6QT(&%G
M86EN+@HK"0D)("HO"B )"0ES<&EN7VQO8VLH)FUM+3YP86=E7W1A8FQE7VQO
M8VLI.PHK"0D):68@*'!T95]P<F5S96YT*"IP86=E7W1A8FQE*2D@>PHK"0D)
I"7)E='5R;B Q.PHK"0D)?0H@"0D)<F5T=7)N("TQ.PH@"0E]"B )?0H`
`
end

