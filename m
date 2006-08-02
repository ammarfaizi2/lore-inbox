Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWHBXCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWHBXCP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 19:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWHBXCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 19:02:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:141 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932181AbWHBXCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 19:02:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=jvZlHBHR0NbLcvqPHEMWGQFk+6O3JgfR2vBdjk8dzvpL2cn2u0YyzGqUls9mOwXP9+Fz/zIAmsKpbBmAGa3D9DpiqwEUOmv0MKjApkJjOYXB75Yc6FZ1AldADmauk6iuIHob0IdB3VJLT06WlmWADnRHfHpaIEWpBrtrC/hU9D4=
Date: Thu, 3 Aug 2006 03:02:11 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] tty_io.c: keep davej sane
Message-ID: <20060802230210.GB6825@martell.zuzino.mipt.ru>
References: <20060802223604.GI3639@redhat.com> <20060802223733.GA20485@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802223733.GA20485@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 06:37:33PM -0400, Dave Jones wrote:
> On Wed, Aug 02, 2006 at 06:36:04PM -0400, Dave Jones wrote:
>  > I knew I'd regret digging in the tty code.
>  > Can someone enlighten me as to what this *should* be doing?
>  > 
>  > int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars,
>  >                 size_t size)
>  > {   
>  >    	.... 
>  >     /* There is a small chance that we need to split the data over
>  >        several buffers. If this is the case we must loop */
>  >     while (unlikely(size > copied));
>  >     return copied;
>  > }   
>  > 
>  > 
>  > Looping I can understand, but forever ?
>  > Given we're not advancing 'copied', can we just kill that while loop?
>  > Or should we be changing it with each iteration?
> 
> Disregard, it's the end of a do { } while.

don't hold back, i need your ack

> I've been staring at this too long.

[PATCH] tty_io.c: keep davej sane

Just comment and next "while" look _very_ wrong. Place { correctly to
hint unsuspecting ones that it's the end of the loop actually.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/tty_io.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -362,10 +362,9 @@ int tty_insert_flip_string(struct tty_st
 		tb->used += space;
 		copied += space;
 		chars += space;
-	}
-	/* There is a small chance that we need to split the data over
-	   several buffers. If this is the case we must loop */
-	while (unlikely(size > copied));
+		/* There is a small chance that we need to split the data over
+		   several buffers. If this is the case we must loop */
+	} while (unlikely(size > copied));
 	return copied;
 }
 EXPORT_SYMBOL(tty_insert_flip_string);
@@ -386,10 +385,9 @@ int tty_insert_flip_string_flags(struct 
 		copied += space;
 		chars += space;
 		flags += space;
-	}
-	/* There is a small chance that we need to split the data over
-	   several buffers. If this is the case we must loop */
-	while (unlikely(size > copied));
+		/* There is a small chance that we need to split the data over
+		   several buffers. If this is the case we must loop */
+	} while (unlikely(size > copied));
 	return copied;
 }
 EXPORT_SYMBOL(tty_insert_flip_string_flags);

