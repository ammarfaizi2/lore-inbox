Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288209AbSACEpc>; Wed, 2 Jan 2002 23:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288208AbSACEpX>; Wed, 2 Jan 2002 23:45:23 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:37893 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288207AbSACEpJ>; Wed, 2 Jan 2002 23:45:09 -0500
Message-ID: <3C33E0D3.B6E932D6@zip.com.au>
Date: Wed, 02 Jan 2002 20:40:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ivan Passos <ivan@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C33BCF3.20BE9E92@cyclades.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Passos wrote:
> 
> (Please CC your answer to me, as I'm not a subscriber of this list.)
> 
> Hello,
> 
> By looking at tty_io.c:_tty_make_name(), it seems that the TTY
> subsystem in the Linux 2.4.x kernel series expects driver.name to be
> in the form "ttyX%d", even if you're not using devfs. I say that
> because as of now the definition in serial.c for this variable is:
> 
> #if defined(CONFIG_DEVFS_FS)
>         serial_driver.name = "tts/%d";
> #else
>         serial_driver.name = "ttyS";
> #endif
> 
> , when it seems it should be:
> 
> #if defined(CONFIG_DEVFS_FS)
>         serial_driver.name = "tts/%d";
> #else
>         serial_driver.name = "ttyS%d";
> #endif
> 

I don't think so.  Some quick grepping indicates that _all_
tty drivers currently use the "ttyS" equivalent if !CONFIG_DEVFS.

Instead, it appears that someone broke tty_name().  Here's the
2.2 kernel's version:

char *tty_name(struct tty_struct *tty, char *buf)
{
        if (tty)
                sprintf(buf, "%s%d", tty->driver.name, TTY_NUMBER(tty));
        else
                strcpy(buf, "NULL tty");
        return buf;
}

And that's much more sensible.  The tty has a name associated with
what it is (eg "ttyS") - correlates with major number, probably.
And it has an instance number.

Which is cleaner, IMO, than embedding printf control strings
in the driver name.

--- linux-2.4.18-pre1/drivers/char/tty_io.c	Wed Dec 26 11:47:40 2001
+++ linux-akpm/drivers/char/tty_io.c	Wed Jan  2 20:39:53 2002
@@ -194,7 +194,7 @@ _tty_make_name(struct tty_struct *tty, c
 	if (!tty) /* Hmm.  NULL pointer.  That's fun. */
 		strcpy(buf, "NULL tty");
 	else
-		sprintf(buf, name,
+		sprintf(buf, "%s%d", name,
 			idx + tty->driver.name_base);
 		
 	return buf;


Does this look (and work) OK to you?

-
