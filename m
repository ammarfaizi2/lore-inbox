Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbRCPFvn>; Fri, 16 Mar 2001 00:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129740AbRCPFvc>; Fri, 16 Mar 2001 00:51:32 -0500
Received: from [216.161.55.93] ([216.161.55.93]:36598 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129749AbRCPFvR>;
	Fri, 16 Mar 2001 00:51:17 -0500
Date: Thu, 15 Mar 2001 21:54:40 -0800
From: Greg KH <greg@kroah.com>
To: borchers@steinerpoint.com, pberger@brimson.com
Cc: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 9 potential copy_*_user bugs in 2.4.1
Message-ID: <20010315215440.A2449@wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, borchers@steinerpoint.com,
	pberger@brimson.com, Dawson Engler <engler@csl.Stanford.EDU>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200103160224.SAA03920@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103160224.SAA03920@csl.Stanford.EDU>; from engler@csl.Stanford.EDU on Thu, Mar 15, 2001 at 06:24:51PM -0800
X-Operating-System: Linux 2.4.2-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 15, 2001 at 06:24:51PM -0800, Dawson Engler wrote:
> Hi,
> 
> I wrote an extension to gcc that does global analysis to determine
> which pointers in 2.4.1 are ever treated as user space pointers (i.e,
> passed to copy_*_user, verify_area, etc) and then makes sure they are
> always treated that way.
> 
> It found what looks to be 9 errors, and  3 cases I'm not sure about.
> I've tried to eliminate false positives, but if any remain, please let
> me know.

<snip>

> ---------------------------------------------------------
> [BUG] Looks like a bug where the memcpy forgets to use the user_buf pointer.
> 
> /u2/engler/mc/oses/linux/2.4.1/drivers/usb/serial/digi_acceleport.c:1288:digi_write: ERROR:PARAM:1271:1288: tainted var 'buf' (from line 1271) used as arg 1 to '__constant_memcpy'
> 
> 	/* copy user data (which can sleep) before getting spin lock */
> 	count = MIN( 64, MIN( count, port->bulk_out_size-2 ) );
> Start --->
> 	if( from_user && copy_from_user( user_buf, buf, count ) ) {
> 		return( -EFAULT );
> 	}
> 
> 	/* be sure only one write proceeds at a time */
> 	/* there are races on the port private buffer */
> 	/* and races to check write_urb->status */
> 
> 	/* wait for urb status clear to submit another urb */
> 	if( port->write_urb->status == -EINPROGRESS
> 	|| priv->dp_write_urb_in_use ) {
> 
> 		/* buffer data if count is 1 (probably put_char) if possible */
> 		if( count == 1 ) {
> 			new_len = MIN( count,
> 				DIGI_OUT_BUF_SIZE-priv->dp_out_buf_len );
> Error --->
> 			memcpy( priv->dp_out_buf+priv->dp_out_buf_len, buf,
> 				new_len );
> 			priv->dp_out_buf_len += new_len;
> 		} else {
> 			new_len = 0;
> 
> ---------------------------------------------------------

Al, Pete, does this patch look good to fix this problem?

(I'll send a separate patch for the other usb-serial problems.)

thanks,

greg k-h

-- 
greg@(kroah|wirex).com

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="digi_acceleport.patch"

--- digi_acceleport.c.original	Thu Mar 15 21:38:10 2001
+++ digi_acceleport.c	Thu Mar 15 21:38:46 2001
@@ -1285,8 +1285,8 @@
 		if( count == 1 ) {
 			new_len = MIN( count,
 				DIGI_OUT_BUF_SIZE-priv->dp_out_buf_len );
-			memcpy( priv->dp_out_buf+priv->dp_out_buf_len, buf,
-				new_len );
+			memcpy( priv->dp_out_buf+priv->dp_out_buf_len, 
+				from_user ? user_buf : buf, new_len );
 			priv->dp_out_buf_len += new_len;
 		} else {
 			new_len = 0;

--wac7ysb48OaltWcw--
