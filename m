Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUGHN2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUGHN2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUGHN2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:28:19 -0400
Received: from kanga.kvack.org ([66.96.29.28]:422 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262905AbUGHN15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:27:57 -0400
Date: Thu, 8 Jul 2004 09:27:45 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-aio@kvack.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6-bk] aio not returning error code(?)
Message-ID: <20040708132745.GG6513@kvack.org>
References: <Pine.LNX.4.60.0407071430170.28653@hermes-1.csi.cam.ac.uk> <20040707223302.GA6513@kvack.org> <1089291383.5891.69.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089291383.5891.69.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anton,

On Thu, Jul 08, 2004 at 01:56:24PM +0100, Anton Altaparmakov wrote:
> You are saying that this is wrong and that no error code is returned
> from io_submit despite its manpage saying that it is so one of the two
> must be wrong, no?

Either or.  Yes, the man page needs to talk about early vs late errors 
(remember that any early error for a given iocb is valid late), or your 
patch needs to be fixed.  Something like the following would be the 
right way of fixing it -- it doesn't report the same error twice (both 
early and late) as your patch did, but it's not clear which was is better.  
There are good arguements in favour of both early and late error 
reporting, and late errors must always be handled by the application.  I 
hope this clears things up to the level of mud. ;-)  Cheers,

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler


--- fs/aio.c.orig	2004-07-08 09:18:02.208534208 -0400
+++ fs/aio.c	2004-07-08 09:23:42.346825328 -0400
@@ -1044,6 +1044,8 @@
 		if (file->f_op->aio_read)
 			ret = file->f_op->aio_read(req, buf,
 					iocb->aio_nbytes, req->ki_pos);
+		else
+			goto out_put_req;
 		break;
 	case IOCB_CMD_PWRITE:
 		ret = -EBADF;
@@ -1059,20 +1061,27 @@
 		if (file->f_op->aio_write)
 			ret = file->f_op->aio_write(req, buf,
 					iocb->aio_nbytes, req->ki_pos);
+		else
+			goto out_put_req;
 		break;
 	case IOCB_CMD_FDSYNC:
 		ret = -EINVAL;
 		if (file->f_op->aio_fsync)
 			ret = file->f_op->aio_fsync(req, 1);
+		else
+			goto out_put_req;
 		break;
 	case IOCB_CMD_FSYNC:
 		ret = -EINVAL;
 		if (file->f_op->aio_fsync)
 			ret = file->f_op->aio_fsync(req, 0);
+		else
+			goto out_put_req;
 		break;
 	default:
 		dprintk("EINVAL: io_submit: no operation provided\n");
 		ret = -EINVAL;
+		goto out_put_req;
 	}
 
 	aio_put_req(req);	/* drop extra ref to req */
