Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbTFVLdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 07:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbTFVLdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 07:33:09 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:18703 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264942AbTFVLc7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 07:32:59 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Ishikawa <ishikawa@yk.rim.or.jp>
Subject: Re: Warning messages during compilation of 2.4.21. (5 files)
Date: Sun, 22 Jun 2003 13:47:01 +0200
User-Agent: KMail/1.5.2
References: <3EF4B98D.33A55CD1@yk.rim.or.jp>
In-Reply-To: <3EF4B98D.33A55CD1@yk.rim.or.jp>
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306221343.26884.fsdeveloper@yahoo.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 21 June 2003 22:01, Ishikawa wrote:
> Hi,

Hi.

[SNIP]
> [1] /usr/src/linux/drivers/char/agp/agpgart_be.c
> ;;;MODULE_AUTHOR("Jeff Hartmann <jhartmann@precisioninsight.com>");
>
>
> agpgart_be.c: In function `agp_generic_create_gatt_table':
> agpgart_be.c:580: warning: assignment from incompatible pointer type
> agpgart_be.c: In function `amd_create_gatt_table':
> agpgart_be.c:2453: warning: assignment from incompatible pointer type
> agpgart_be.c:2454: warning: assignment from incompatible pointer type
> agpgart_be.c: In function `amd_free_gatt_table':
> agpgart_be.c:2480: warning: assignment from incompatible pointer type
> agpgart_be.c:2481: warning: assignment from incompatible pointer type
>
> There are three chunks. I will investigate this in turn.
> (All of them seem to be fixed by (void *) cast on the Right-Hand-Side
> of assignments.)
>
> []  agpgart_be.c:580: warning: assignment from incompatible pointer type
>
> 	char *table;
>            ...
> 580 -->	agp_bridge.gatt_table_real = (unsigned long *) table;
> 	agp_gatt_table = (void *)table;


agp_bridge.gatt_table_real = (u32*)table;
u32* casts seem to be more correct to me.
I haven't tested it.

[SNIP]
>
> ---
>
> The following files keyboard.c and vt.c
> produce warnings in a somewhat convinced manner in that
> the warning is produced by explicit checking of
> argument values: however as it stands, the
> checking always produce TRUE or FALSE, a compile-time
> constant, so to speak.
>
> [2] /usr/src/linux/drivers/char/keyboard.c
>
> keyboard.c: In function `do_fn':
> keyboard.c:644: warning: comparison is always true due to limited range
> of data type
>
> static void do_fn(unsigned char value, char up_flag)
> {
> 	if (up_flag)
> 		return;
> --->	if (value < SIZE(func_table)) {
> 		if (func_table[value])
> 			puts_queue(func_table[value]);
> 	} else
> 		printk(KERN_ERR "do_fn called with value=%d\n", value);
> }
>
> SIZE is a macro to return the size of an array.
>
> The size of func_table is MAX_NR_FUNC.
>
> cd /usr/src/linux/drivers/char/
> grep -n	 -e func_table *.[ch] /dev/null
> defkeymap.c:191:char *func_table[MAX_NR_FUNC] = {
> 		     ...
>
>
> MAX_NR_FUNC is defined to be 256.
> cd /usr/src/linux/include/linux/
> grep -n	 -e NR_FUNC *.h /dev/null
> kbd_kern.h:11:extern char *func_table[MAX_NR_FUNC];
> keyboard.h:32:#define MAX_NR_FUNC	256	/* max nr of strings assigned to
> keys */
>
> So the confition inside if() is always TRUE as it stands.
>
> Solution: see below for solution to [3].
>
> [3] /usr/src/linux/drivers/char/vt.c
>
> vt.c: In function `do_kdsk_ioctl':
> vt.c:166: warning: comparison is always false due to limited range of
> data type
> vt.c: In function `do_kdgkb_ioctl':
> vt.c:283: warning: comparison is always false due to limited range of
> data type
>
>     #define i (tmp.kb_index)
>     #define s (tmp.kb_table)
>     #define v (tmp.kb_value)
>
> 166:
> -->    	if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
> 	    	return -EINVAL;
>
> 283:
> 	if (tmp.kb_func >= MAX_NR_FUNC)
> 		return -EINVAL;
>
> NR_KEYS is defined as 128.
> keyboard.h:18:#define NR_KEYS		128
> keyboard.h:28:extern unsigned short plain_map[NR_KEYS];
>
> Solution :
>
> I observe the desire to check the parameter value,
> whic probably caused grief in the past.
>
> Maybe cast the value to an integer value to
> suppress the warning? It might be a little far-fetched
> to do so just to suppress warning messages in
> the compilation log, but I can see that for future
> qaultiy-assurance of linux kernel efforts, such
> hand-twisting may be necessary.
>
> (for example, the line 283 of vt.c could be re-written to
>    int kludge_i; /* to shut up warning */
>
>    if((kludge_i = tmp.kb_func) >= MAX_NR_FUNC)
>        return -EINVAL;

Some days ago, I've also looked over it to find a solution. :)
But IMHO the kludge_i is far more uglier than the warning.
What about that:

if((int)tmp.kb_func >= MAX_NR_FUNC)
	return -EINVAL;

Doesn't it work?


> Happy Hacking,

- --
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 13:26:20 up  3:08,  1 user,  load average: 1.00, 1.00, 1.00

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+9Zc1oxoigfggmSgRAuXqAJ9rO6MGlc5lonIM3oeJPjBZpX+q3wCfWjmZ
HkE8NZXVBWqVS6TKZ9RKYOs=
=MICc
-----END PGP SIGNATURE-----

