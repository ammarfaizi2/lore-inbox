Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTIPIpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 04:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTIPIpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 04:45:42 -0400
Received: from mail-08.iinet.net.au ([203.59.3.40]:56028 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261681AbTIPIpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 04:45:40 -0400
Message-ID: <3F66CDB6.7000601@ii.net>
Date: Tue, 16 Sep 2003 16:45:42 +0800
From: Wade <neroz@ii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Yu Chen <dychen@stanford.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Content-Type: multipart/mixed;
 boundary="------------070201080000020604040700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070201080000020604040700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Yu Chen wrote:
> Hi All,
> 
> I'm with the Stanford Meta-level Compilation research group, and I
> have a set of memory leaks on error paths for the 2.6.0-test5 kernel.
> (I also have error reports for 2.4.18 and a couple other kernels if
> anyone is interested).
> 
> There may be one or more "GOTO -->" markers showing the different
> paths of execution that can occur between where the memory is
> allocated and where the function returns.
> 
> My checker identifies error paths with a learning algorithm on
> features surrounding goto and return statements.  I'd greatly
> appreciate any comments or confirmation on these bugs.
> 
> Thanks!
> 
> ---
> David Yu Chen
> http://www.stanford.edu/~dychen/
[snip]
> 
> [FILE:  2.6.0-test5/drivers/char/vt_ioctl.c]
> [FUNC:  do_kdsk_ioctl]
> [LINES: 133-150]
> [VAR:   key_map]
>  128:
>  129:			if (keymap_count >= MAX_NR_OF_USER_KEYMAPS &&
>  130:			    !capable(CAP_SYS_RESOURCE))
>  131:				return -EPERM;
>  132:
> START -->
>  133:			key_map = (ushort *) kmalloc(sizeof(plain_map),
>  134:						     GFP_KERNEL);
>  135:			if (!key_map)
>  136:				return -ENOMEM;
>  137:			key_maps[s] = key_map;
>  138:			key_map[0] = U(K_ALLOCATED);
>         ... DELETED 6 lines ...
>  145:			break;	/* nothing to do */
>  146:		/*
>  147:		 * Attention Key.
>  148:		 */
>  149:		if (((ov == K_SAK) || (v == K_SAK)) && !capable(CAP_SYS_ADMIN))
> END -->
>  150:			return -EPERM;
>  151:		key_map[i] = U(v);
>  152:		if (!s && (KTYP(ov) == KT_SHIFT || KTYP(v) == KT_SHIFT))
>  153:			compute_shiftstate();
>  154:		break;
>  155:	}
> ---------------------------------------------------------
> 

Is the attached correct?



--------------070201080000020604040700
Content-Type: text/plain;
 name="vt_ioctl_memleak.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vt_ioctl_memleak.diff"

--- linux-2.6.0-test5.old/drivers/char/vt_ioctl.c	2003-08-23 07:57:57.000000000 +0800
+++ linux-2.6.0-test5.new/drivers/char/vt_ioctl.c	2003-09-16 16:17:00.000000000 +0800
@@ -146,8 +146,10 @@
 		/*
 		 * Attention Key.
 		 */
-		if (((ov == K_SAK) || (v == K_SAK)) && !capable(CAP_SYS_ADMIN))
+		if (((ov == K_SAK) || (v == K_SAK)) && !capable(CAP_SYS_ADMIN)) {
+			kfree(key_map);
 			return -EPERM;
+		}
 		key_map[i] = U(v);
 		if (!s && (KTYP(ov) == KT_SHIFT || KTYP(v) == KT_SHIFT))
 			compute_shiftstate();

--------------070201080000020604040700--

