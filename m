Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290465AbSAQVNA>; Thu, 17 Jan 2002 16:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290466AbSAQVMv>; Thu, 17 Jan 2002 16:12:51 -0500
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:33292 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S290465AbSAQVMr>;
	Thu, 17 Jan 2002 16:12:47 -0500
From: "Tim Pepper" <tpepper@vato.org>
Date: Thu, 17 Jan 2002 13:12:45 -0800
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BLKGETSIZE64 (bytes or sectors?)
Message-ID: <20020117131245.A11241@vato.org>
In-Reply-To: <Pine.LNX.4.33.0201171420100.2747-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201171420100.2747-100000@localhost.localdomain>; from Matt_Domsch@Dell.com on Thu, Jan 17, 2002 at 02:28:52PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Jan at 14:28:52 -0600 Matt_Domsch@Dell.com done said:
> Is the BLKGETSIZE64 ioctl supposed to return the size of the device in 
> bytes (as the comment says, and is implemented in all places *except* 
> blkpg.c), or in sectors (as is implemented in blkpg.c since 2.4.15)?
> 
> It would seem that blkpg.c gets it wrong, that it should be in bytes.  
> Assuming that's the case, here's the patch to fix it against 2.4.18-pre4.

I was just in the process of writing a post for the same thing.  Wouldn't it
be better to do the following (against 2.4.17).

Tim

-- 
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************


--- linux-2.4.17-orig/blkpg.c	Thu Jan 17 13:02:19 2002
+++ linux-2.4.17/blkpg.c	Thu Jan 17 13:06:33 2002
@@ -246,8 +246,14 @@
 
 			if (cmd == BLKGETSIZE)
 				return put_user((unsigned long)ullval, (unsigned long *)arg);
-			else
+			else {
+				if (hardsect_size[MAJOR(dev)][MINOR(dev)]) {
+					ullval *= hardsect_size[MAJOR(dev)][MINOR(dev)];
+				} else {
+					ullval *= 512;
+				}
 				return put_user(ullval, (u64 *)arg);
+			}
 #if 0
 		case BLKRRPART: /* Re-read partition tables */
 			if (!capable(CAP_SYS_ADMIN)) 
