Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbTFVNwf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 09:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbTFVNwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 09:52:35 -0400
Received: from pl266.nas911.n-yokohama.nttpc.ne.jp ([210.139.38.10]:36035 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id S265234AbTFVNw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 09:52:28 -0400
Message-ID: <3EF5B80C.7F5340F7@yk.rim.or.jp>
Date: Sun, 22 Jun 2003 23:07:08 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Michael Buesch <fsdeveloper@yahoo.de>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Warning messages during compilation of 2.4.21. (5 files)
References: <3EF4B98D.33A55CD1@yk.rim.or.jp> <200306221343.26884.fsdeveloper@yahoo.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I am sending this again because I forgot to add CC: linux-kernel
address.)

Hi,

Thank you for your comment.

        ... omission ...
> agp_bridge.gatt_table_real = (u32*)table;
> u32* casts seem to be more correct to me.
> I haven't tested it.

You are right. (u32 *) cast is more suitable in the assignment to
gatt_table_real member.
(I was in a hurry and just thought (void*) was
useful in places where we are sure
we are doing something correct (like assigning
a pointer to a different pointer [of different type.]), and
yet do not want to bother much with the correct
types of the LHS of assignment.
(Comment added: thus using (void*) to save the
checking of the type of LHS side.).


> [SNIP]
> >
> > ---
> >
> > The following files keyboard.c and vt.c
> > produce warnings in a somewhat convinced manner in that
> > the warning is produced by explicit checking of
> > argument values: however as it stands, the
> > checking always produce TRUE or FALSE, a compile-time
> > constant, so to speak.
> >
> > [2] /usr/src/linux/drivers/char/keyboard.c
> >
> > keyboard.c: In function `do_fn':
> > keyboard.c:644: warning: comparison is always true due to limited range
> > of data type
> >
> > static void do_fn(unsigned char value, char up_flag)
> > {
> >       if (up_flag)
> >               return;
> > --->  if (value < SIZE(func_table)) {
> >               if (func_table[value])
> >                       puts_queue(func_table[value]);
> >       } else
> >               printk(KERN_ERR "do_fn called with value=%d\n", value);
> > }
> >
> > SIZE is a macro to return the size of an array.
> >
> > The size of func_table is MAX_NR_FUNC.
> >
> > cd /usr/src/linux/drivers/char/
> > grep -n        -e func_table *.[ch] /dev/null
> > defkeymap.c:191:char *func_table[MAX_NR_FUNC] = {
> >                    ...
> >
> >
> > MAX_NR_FUNC is defined to be 256.
> > cd /usr/src/linux/include/linux/
> > grep -n        -e NR_FUNC *.h /dev/null
> > kbd_kern.h:11:extern char *func_table[MAX_NR_FUNC];
> > keyboard.h:32:#define MAX_NR_FUNC     256     /* max nr of strings assigned to
> > keys */
> >
> > So the confition inside if() is always TRUE as it stands.
> >
> > Solution: see below for solution to [3].
> >
> > [3] /usr/src/linux/drivers/char/vt.c
> >
> > vt.c: In function `do_kdsk_ioctl':
> > vt.c:166: warning: comparison is always false due to limited range of
> > data type
> > vt.c: In function `do_kdgkb_ioctl':
> > vt.c:283: warning: comparison is always false due to limited range of
> > data type
> >
> >     #define i (tmp.kb_index)
> >     #define s (tmp.kb_table)
> >     #define v (tmp.kb_value)
> >
> > 166:
> > -->           if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
> >               return -EINVAL;
> >
> > 283:
> >       if (tmp.kb_func >= MAX_NR_FUNC)
> >               return -EINVAL;
> >
> > NR_KEYS is defined as 128.
> > keyboard.h:18:#define NR_KEYS         128
> > keyboard.h:28:extern unsigned short plain_map[NR_KEYS];
> >
> > Solution :
> >
> > I observe the desire to check the parameter value,
> > whic probably caused grief in the past.
> >
> > Maybe cast the value to an integer value to
> > suppress the warning? It might be a little far-fetched
> > to do so just to suppress warning messages in
> > the compilation log, but I can see that for future
> > qaultiy-assurance of linux kernel efforts, such
> > hand-twisting may be necessary.
> >
> > (for example, the line 283 of vt.c could be re-written to
> >    int kludge_i; /* to shut up warning */
> >
> >    if((kludge_i = tmp.kb_func) >= MAX_NR_FUNC)
> >        return -EINVAL;
> 
> Some days ago, I've also looked over it to find a solution. :)
> But IMHO the kludge_i is far more uglier than the warning.
> What about that:
> 
> if((int)tmp.kb_func >= MAX_NR_FUNC)
>         return -EINVAL;
> 
> Doesn't it work?

Unfortunately, GCC 3.3 is so clever that
mere type casting (as you suggested) still produced warning.
Only after assigning to an integer variable, I see
the warning message gone. Tough luck.
Agreed. The remedy is very ugly.

Regards,

Ishikawa Chiaki

-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
