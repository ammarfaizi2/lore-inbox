Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131942AbRDPSpE>; Mon, 16 Apr 2001 14:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131949AbRDPSoy>; Mon, 16 Apr 2001 14:44:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26895 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131942AbRDPSor>;
	Mon, 16 Apr 2001 14:44:47 -0400
Date: Mon, 16 Apr 2001 20:44:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/block/loop.c:max_loop
Message-ID: <20010416204437.K9539@suse.de>
In-Reply-To: <20010416173942.G6934@informatics.muni.cz> <20010416183637.G9539@suse.de> <20010416200012.H6934@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20010416200012.H6934@informatics.muni.cz>; from kas@informatics.muni.cz on Mon, Apr 16, 2001 at 08:00:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16 2001, Jan Kasprzak wrote:
> Jens Axboe wrote:
> : On Mon, Apr 16 2001, Jan Kasprzak wrote:
> : > 	Hello,
> : > 
> : > 	I run a relatively large FTP server, and I've just reached
> : > the max_loop limit of loop devices here (I use loopback mount of ISO 9660
> : > images of Linux distros here). Is there any reason for keeping
> : > the max_loop variable in loop.c set to 8?
> : 
> : Memory requirements -- nothing prevents you from loading it with a
> : bigger max count though...
> : 
> 	I would suggest to make the limit configurable by /proc or
> ioctl() in run-time. Or even better, to make all allocations on
> first /dev/loopN open. Should I try to implement something like that?

Overkill, imo. If you use a module setup, add a max_loop to your
/etc/modules.conf. If not, add the identical max_loop to your lilo.conf
append line.

Ok, just noticed that the module option is missing. Attached patch
should rectify that oversight.

-- 
Jens Axboe


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=loop-maxloop-mod-1

--- /opt/kernel/linux-2.4.4-pre3/drivers/block/loop.c	Sun Apr 15 16:24:12 2001
+++ drivers/block/loop.c	Mon Apr 16 20:43:39 2001
@@ -476,7 +476,7 @@
 	 */
 	bh = loop_get_buffer(lo, rbh);
 	bh->b_private = rbh;
-	IV = loop_get_iv(lo, bh->b_rsector);
+	IV = loop_get_iv(lo, rbh->b_rsector);
 	if (rw == WRITE) {
 		set_bit(BH_Dirty, &bh->b_state);
 		if (lo_do_transfer(lo, WRITE, bh->b_data, rbh->b_data,
@@ -620,7 +620,6 @@
 		 * If we can't read - sorry. If we only can't write - well,
 		 * it's going to be read-only.
 		 */
-		error = -EINVAL;
 		if (!aops->readpage)
 			goto out_putf;
 
@@ -1034,6 +1033,8 @@
 
 module_init(loop_init);
 module_exit(loop_exit);
+
+MODULE_PARM(max_loop, "i");
 
 #ifndef MODULE
 static int __init max_loop_setup(char *str)

--G4iJoqBmSsgzjUCe--
