Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRJQJL1>; Wed, 17 Oct 2001 05:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275126AbRJQJLS>; Wed, 17 Oct 2001 05:11:18 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:49159 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S271911AbRJQJLO>; Wed, 17 Oct 2001 05:11:14 -0400
Message-ID: <3BCD4C0C.DF5D5C0@loewe-komp.de>
Date: Wed, 17 Oct 2001 11:14:52 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: NFS related Oops in 2.4.[39]-xfs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

noisy:/usr/src/linux # uname -a
Linux noisy 2.4.3-XFS #8 SMP Sam Mai 19 18:21:36 CEST 2001 i686 unknown

dual board with just one processor
/usr/local and /home on LogicalVolumes
tried also 2.4.9-XFS (but see below)

------------ oops -------------
Warning (compare_maps): ksyms_base symbol __rta_fill_R__ver___rta_fill not found in
System.map.  Ignoring ksyms_base entry
[other warnings stripped]
Oops: 0000
CPU:    0
EIP:    0010:<c016b3c4>
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: cff805b8 edx: 00000010
esi: ca018260   edi: ca0182e0   ebp: cb9e5800 esp: cb9edeec
ds: 0018   es: 0018   ss: 0018
Stack: 0100708b ca018360 c016b7d8 ca0182e0 00000002 cba07000 cb9efc00 cb9e5800
       ce078bc4 ca018360 00000000 ca018360 c016bb70 ce078a80 0102a048 00000005
Call Trace: <c01bb7d8> <c016bb70> <c016a0b5>c0169b73> <c02a60bf> <c016999d> <c01054c4>
Code: 8b 40 10 39 d0 74 21 8d 58 c8 39 f3 75 06 8b 5a 04 83 c3 c8

>>EIP; c016b3c4 <nfsd_findparent+78/e8>   <=====
Trace; c01bb7d8 <xfs_buf_item_bits+38/58>
Trace; c016bb70 <fh_verify+26c/48c>
Trace; c016a0b5 <nfsd_proc_getattr+91/98>
Code;  c016b3c4 <nfsd_findparent+78/e8>
00000000 <_EIP>:
Code;  c016b3c4 <nfsd_findparent+78/e8>   <=====
   0:   8b 40 10                  mov    0x10(%eax),%eax   <=====
Code;  c016b3c7 <nfsd_findparent+7b/e8>
   3:   39 d0                     cmp    %edx,%eax
Code;  c016b3c9 <nfsd_findparent+7d/e8>
   5:   74 21                     je     28 <_EIP+0x28> c016b3ec <nfsd_findparent+a0/e8>
Code;  c016b3cb <nfsd_findparent+7f/e8>
   7:   8d 58 c8                  lea    0xffffffc8(%eax),%ebx
Code;  c016b3ce <nfsd_findparent+82/e8>
   a:   39 f3                     cmp    %esi,%ebx
Code;  c016b3d0 <nfsd_findparent+84/e8>
   c:   75 06                     jne    14 <_EIP+0x14> c016b3d8 <nfsd_findparent+8c/e8>
Code;  c016b3d2 <nfsd_findparent+86/e8>
   e:   8b 5a 04                  mov    0x4(%edx),%ebx
Code;  c016b3d5 <nfsd_findparent+89/e8>
  11:   83 c3 c8                  add    $0xffffffc8,%ebx


31 warnings issued.  Results may not be reliable.
------------ oops -------------

Why do I get all those warnings about symbol mismatch?


The code causing the Oops:

struct dentry *nfsd_findparent(struct dentry *child)
{
        struct dentry *tdentry, *pdentry;
        tdentry = d_alloc(child, &(const struct qstr) {"..", 2, 0});
        if (!tdentry)
                return ERR_PTR(-ENOMEM);
 
        /* I'm going to assume that if the returned dentry is different, then
         * it is well connected.  But nobody returns different dentrys do they?
         */
        pdentry = child->d_inode->i_op->lookup(child->d_inode, tdentry);
        d_drop(tdentry); /* we never want ".." hashed */
        if (!pdentry) {
                /* I don't want to return a ".." dentry.
                 * I would prefer to return an unconnected "IS_ROOT" dentry,
                 * though a properly connected dentry is even better
                 */
                /* if first or last of alias list is not tdentry, use that
                 * else make a root dentry
                 */
                struct list_head *aliases = &tdentry->d_inode->i_dentry;
                spin_lock(&dcache_lock);
                if (aliases->next != aliases) {         <=========== CRASH
!!!!!!!!!!!!!!!!!!!!!!!
                        pdentry = list_entry(aliases->next, struct dentry, d_alias);
                        if (pdentry == tdentry)
                                pdentry = list_entry(aliases->prev, struct dentry,
d_alias);
                        if (pdentry == tdentry)
                                pdentry = NULL;
                        if (pdentry) dget_locked(pdentry);
                }
                spin_unlock(&dcache_lock);
                if (pdentry == NULL) {
                        pdentry = d_alloc_root(igrab(tdentry->d_inode));
                        if (pdentry) {
                                pdentry->d_flags |= DCACHE_NFSD_DISCONNECTED;
                                d_rehash(pdentry);
                        }
                }
                if (pdentry == NULL)
                        pdentry = ERR_PTR(-ENOMEM);
        }
        dput(tdentry); /* it is not hashed, it will be discarded */
        return pdentry;
}


(gdb) disass nfsd_findparent
Dump of assembler code for function nfsd_findparent:
0xc016b34c <nfsd_findparent>:   push   %esi
0xc016b34d <nfsd_findparent+1>: push   %ebx
0xc016b34e <nfsd_findparent+2>: mov    0xc(%esp,1),%ebx
0xc016b352 <nfsd_findparent+6>: push   $0xc02ce724
0xc016b357 <nfsd_findparent+11>:        push   %ebx
0xc016b358 <nfsd_findparent+12>:        call   0xc0144608 <d_alloc>
0xc016b35d <nfsd_findparent+17>:        mov    %eax,%esi
0xc016b35f <nfsd_findparent+19>:        add    $0x8,%esp
        tdentry = d_alloc(child, &(const struct qstr) {"..", 2, 0});
		
0xc016b362 <nfsd_findparent+22>:        test   %esi,%esi
        if (!tdentry)
0xc016b364 <nfsd_findparent+24>:        jne    0xc016b370 <nfsd_findparent+36>
0xc016b366 <nfsd_findparent+26>:        mov    $0xfffffff4,%eax
0xc016b36b <nfsd_findparent+31>:        jmp    0xc016b431 <nfsd_findparent+229>
			return ERR_PTR(-ENOMEM);
			

0xc016b370 <nfsd_findparent+36>:        mov    0x8(%ebx),%eax
0xc016b373 <nfsd_findparent+39>:        mov    0x84(%eax),%edx
0xc016b379 <nfsd_findparent+45>:        push   %esi
0xc016b37a <nfsd_findparent+46>:        push   %eax
0xc016b37b <nfsd_findparent+47>:        mov    0x4(%edx),%eax
0xc016b37e <nfsd_findparent+50>:        call   *%eax
0xc016b380 <nfsd_findparent+52>:        mov    %eax,%ebx
0xc016b382 <nfsd_findparent+54>:        add    $0x8,%esp
        pdentry = child->d_inode->i_op->lookup(child->d_inode, tdentry);
		
static __inline__ void d_drop(struct dentry * dentry)
{
        spin_lock(&dcache_lock);
        list_del(&dentry->d_hash);
        INIT_LIST_HEAD(&dentry->d_hash);
        spin_unlock(&dcache_lock);
}		

0xc016b385 <nfsd_findparent+57>:        lock decb 0xc0329898
0xc016b38c <nfsd_findparent+64>:        js     0xc02aefa4 <stext_lock+12548>
0xc016b392 <nfsd_findparent+70>:        lea    0x18(%esi),%eax
0xc016b395 <nfsd_findparent+73>:        mov    0x4(%eax),%ecx
0xc016b398 <nfsd_findparent+76>:        mov    0x18(%esi),%edx
0xc016b39b <nfsd_findparent+79>:        mov    %ecx,0x4(%edx)
0xc016b39e <nfsd_findparent+82>:        mov    %edx,(%ecx)
0xc016b3a0 <nfsd_findparent+84>:        mov    %eax,0x18(%esi)
0xc016b3a3 <nfsd_findparent+87>:        mov    %eax,0x1c(%esi)
0xc016b3a6 <nfsd_findparent+90>:        movb   $0x1,0xc0329898

        d_drop(tdentry); /* we never want ".." hashed */


0xc016b3ad <nfsd_findparent+97>:        test   %ebx,%ebx
0xc016b3af <nfsd_findparent+99>:        jne    0xc016b426 <nfsd_findparent+218>
        if (!pdentry) {

0xc016b3b1 <nfsd_findparent+101>:       mov    0x8(%esi),%eax
0xc016b3b4 <nfsd_findparent+104>:       lea    0x10(%eax),%edx   // edx holds aliases
                struct list_head *aliases = &tdentry->d_inode->i_dentry; 
				
		// is tdentry->d_inode->i_dentry not valid anymore?  aliases gets NULL
				
				
0xc016b3b7 <nfsd_findparent+107>:       lock decb 0xc0329898
0xc016b3be <nfsd_findparent+114>:       js     0xc02aefb4 <stext_lock+12564>
                spin_lock(&dcache_lock);
				
0xc016b3c4 <nfsd_findparent+120>:       mov    0x10(%eax),%eax    <=====================
CRASH !!!
0xc016b3c7 <nfsd_findparent+123>:       cmp    %edx,%eax   // eax holds aliases->next
                if (aliases->next != aliases) { 
				
0xc016b3c9 <nfsd_findparent+125>:       je     0xc016b3ec <nfsd_findparent+160>
0xc016b3cb <nfsd_findparent+127>:       lea    0xffffffc8(%eax),%ebx
                        pdentry = list_entry(aliases->next, struct dentry, d_alias);

0xc016b3ce <nfsd_findparent+130>:       cmp    %esi,%ebx
0xc016b3d0 <nfsd_findparent+132>:       jne    0xc016b3d8 <nfsd_findparent+140>
0xc016b3d2 <nfsd_findparent+134>:       mov    0x4(%edx),%ebx
0xc016b3d5 <nfsd_findparent+137>:       add    $0xffffffc8,%ebx

0xc016b3d8 <nfsd_findparent+140>:       xor    %eax,%eax
0xc016b3da <nfsd_findparent+142>:       cmp    %esi,%ebx
0xc016b3dc <nfsd_findparent+144>:       cmove  %eax,%ebx
0xc016b3df <nfsd_findparent+147>:       test   %ebx,%ebx
0xc016b3e1 <nfsd_findparent+149>:       je     0xc016b3ec <nfsd_findparent+160>
0xc016b3e3 <nfsd_findparent+151>:       push   %ebx
0xc016b3e4 <nfsd_findparent+152>:       call   0xc0144080 <dget_locked>
0xc016b3e9 <nfsd_findparent+157>:       add    $0x4,%esp
                        if (pdentry) dget_locked(pdentry);  
						
0xc016b3ec <nfsd_findparent+160>:       movb   $0x1,0xc0329898
0xc016b3f3 <nfsd_findparent+167>:       test   %ebx,%ebx
0xc016b3f5 <nfsd_findparent+169>:       jne    0xc016b41c <nfsd_findparent+208>
                spin_unlock(&dcache_lock);
				
0xc016b3f7 <nfsd_findparent+171>:       mov    0x8(%esi),%eax
0xc016b3fa <nfsd_findparent+174>:       push   %eax
0xc016b3fb <nfsd_findparent+175>:       call   0xc0145ee8 <igrab>
0xc016b400 <nfsd_findparent+180>:       push   %eax
0xc016b401 <nfsd_findparent+181>:       call   0xc01447f4 <d_alloc_root>
0xc016b406 <nfsd_findparent+186>:       mov    %eax,%ebx
0xc016b408 <nfsd_findparent+188>:       add    $0x8,%esp
                        pdentry = d_alloc_root(igrab(tdentry->d_inode));

0xc016b40b <nfsd_findparent+191>:       test   %ebx,%ebx
0xc016b40d <nfsd_findparent+193>:       je     0xc016b41c <nfsd_findparent+208>
0xc016b40f <nfsd_findparent+195>:       orb    $0x4,0x4(%ebx)
0xc016b413 <nfsd_findparent+199>:       push   %ebx
0xc016b414 <nfsd_findparent+200>:       call   0xc0144ab4 <d_rehash>
0xc016b419 <nfsd_findparent+205>:       add    $0x4,%esp
0xc016b41c <nfsd_findparent+208>:       mov    $0xfffffff4,%eax
0xc016b421 <nfsd_findparent+213>:       test   %ebx,%ebx
0xc016b423 <nfsd_findparent+215>:       cmove  %eax,%ebx
0xc016b426 <nfsd_findparent+218>:       push   %esi
        }  /* if (!pdentry) */
0xc016b427 <nfsd_findparent+219>:       call   0xc0143e90 <dput>
0xc016b42c <nfsd_findparent+224>:       mov    %ebx,%eax
0xc016b42e <nfsd_findparent+226>:       add    $0x4,%esp
0xc016b431 <nfsd_findparent+229>:       pop    %ebx
0xc016b432 <nfsd_findparent+230>:       pop    %esi
0xc016b433 <nfsd_findparent+231>:       ret
End of assembler dump.
(gdb)


2.4.3-xfs is compiled with gcc 2.95.2
2.4.9-XFS is compiled with gcc 2.91.6

After the crash I tried to reboot, but it quickly failed again.
reboot   system boot  2.4.3-XFS        Mon Oct 15 18:20          (21:49)
reboot   system boot  2.4.3-XFS        Mon Oct 15 18:17          (21:52)
reboot   system boot  2.4.3-XFS        Mon Oct 15 18:13          (21:57)

reboot   system boot  2.4.3-XFS        Thu Oct 11 16:51         (4+23:18)
reboot   system boot  2.4.3-XFS        Thu Oct 11 16:32         (4+23:37)
reboot   system boot  2.4.3-XFS        Thu Oct 11 16:28         (4+23:41)
reboot   system boot  2.4.3-XFS        Thu Oct 11 16:23         (4+23:46)
reboot   system boot  2.4.3-XFS        Thu Oct 11 16:12         (4+23:57)
reboot   system boot  2.4.3-XFS        Thu Oct 11 15:05         (5+01:04)

reboot   system boot  2.4.9-xfs        Thu Oct  4 17:02         (11+23:08)
reboot   system boot  2.4.9-xfs        Thu Oct  4 16:54         (11+23:15)
reboot   system boot  2.4.3-XFS        Thu Oct  4 16:47         (11+23:23)
reboot   system boot  2.4.9-xfs        Thu Oct  4 16:39         (11+23:31)
reboot   system boot  2.4.9-xfs        Thu Oct  4 16:14         (11+23:55)


To recover I had to unplug/powerdown all connected clients. :-( Uhh.
I think 2.4.9 crashed at the same instructions. But I can't reproduce
it on demand (hey, in the meantime we can work!).
Seeing the NFS related changes in 2.4.10: should I upgrade?
We use only NFSv2. Is NFSv3 more stable, if that matters here?

The machine with 2.4.3 was up for several months - with light load.
Now the number of crashes (with 6 NFS clients using /home + cvs) went up.

We do mount our compile environment in a strange way:

NOTE: /server is a symlink to /usr/local/export
# See exports(5) for a description.
# This file contains a list of all directories exported to other computers.
# It is used by rpc.nfsd and rpc.mountd.
/opt/xxx                        *.xxx(ro)
/home                           *.xxx(rw)
/tmp                            *.xxx(rw)
/usr/local/export               *.xxx(rw)


/etc/fstab
devserv:/server/compileenv/lib/lib                 \
	/compenv/xxx/lib               nfs  ro,auto 0 0
devserv:/server/compileenv/usr_lib/usr/lib         \
	/compenv/xxx/usr_lib           nfs  ro,auto 0 0
devserv:/server/compileenv/gcc-lib                 \
	/compenv/xxx/gcc-lib           nfs  ro,exec,auto    0 0
devserv:/server/compileenv/usr_include/usr/include \
	/compenv/xxx/usr_include       nfs  ro,auto 0 0
devserv:/server/compileenv/usr_linux/usr/linux/include  \
	/compenv/xxx/usr_linux_include         nfs  ro,auto 0 0

Would it help to mount a single /usr/local/export and work with a 
symlink tree (as I actually do with autofs) ?
What can cause the "invalid" dentries? Did someone remove some files
or were some dentries de'hashed because of dcache growth?

As workaround I will do:

                struct list_head *aliases = &tdentry->d_inode->i_dentry;

                if (aliases && (aliases->next != aliases) ) {
                        spin_lock(&dcache_lock);
                        pdentry = list_entry(aliases->next, struct dentry, d_alias);
                        if (pdentry == tdentry)
                                pdentry = list_entry(aliases->prev, struct dentry,
d_alias);
                        if (pdentry == tdentry)
                                pdentry = NULL;
                        if (pdentry) dget_locked(pdentry);
                        spin_unlock(&dcache_lock);
                } else
                     pdentry=NULL;
