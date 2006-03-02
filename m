Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWCBR7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWCBR7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWCBR7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:59:12 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:9755 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751592AbWCBR7L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:59:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fos5E0pdURjOdFo7oLmBJKj5CGo63cuIOGbL9VNgR9NBablibWdUe815RVJyUVvcBe/QWfWdijdtVmWQkzR2aR1MKPdxfjcHINtuz/mI8BbA/kKETOK0JGCHAI2B9P5RQJ+lRTwr2cslVfimiWlWqlpIAf9Yt+ZL+jMSd/uSXiY=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Steffen Weber <email@steffenweber.net>
Subject: Re: Another compile problem with 2.6.15.5 on AMD64
Date: Thu, 2 Mar 2006 18:59:29 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <44071AF3.1010400@steffenweber.net> <9a8748490603020935h4936ae0eob4bcf107cc75c923@mail.gmail.com> <44073037.2090709@steffenweber.net>
In-Reply-To: <44073037.2090709@steffenweber.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603021859.29728.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 18:49, Steffen Weber wrote:
> Jesper Juhl wrote:
> > On 3/2/06, Steffen Weber <email@steffenweber.net> wrote:
> >> Jesper Juhl wrote:
> >>> On Thursday 02 March 2006 17:18, Steffen Weber wrote:
> >>>> I´m getting a compile error with 2.6.15.5 on x86_64 using GCC 3.4.4
> >>>> (does not seem to be related to the NFS one):
> >>>>
> >>>>    CC      mm/mempolicy.o
> >>>> mm/mempolicy.c: In function `get_nodes':
> >>>> mm/mempolicy.c:527: error: `BITS_PER_BYTE' undeclared (first use in
> >>>> this function)
> >>>> mm/mempolicy.c:527: error: (Each undeclared identifier is reported only
> >>>> once
> >>>> mm/mempolicy.c:527: error: for each function it appears in.)
> >>>>
> >>> Try the following (untested patch).
> >> Thanks for your reply, but this patch does not solve the problem (same
> >> error message). I´ve appended my .config in case that might help.
> >>
> > 
> > Hmm, types.h contains the
> > 
> > #define BITS_PER_BYTE 8
> > 
> > that mmpolicy.c needs, so including that header should do the trick... odd..
> > I'll look at the code a bit more.
> There is no BITS_PER_BYTE in include/types.h. I´ve grepped through the 
> kernel source (2.6.15 and 2.6.15.5) and found that BITS_PER_BYTE is 
> defined only in arch/i386/mach-voyager/voyager_cat.c
> 

Whoops, I was looking here : http://sosdg.org/~coywolf/lxr/source/include/linux/types.h#L11

Try this patch instead : 



Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/i386/mach-voyager/voyager_cat.c |    1 -
 include/linux/types.h                |    2 ++
 mm/mempolicy.c                       |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.15.5/mm/mempolicy.c~	2006-03-02 18:05:18.000000000 +0100
+++ linux-2.6.15.5/mm/mempolicy.c	2006-03-02 18:05:18.000000000 +0100
@@ -82,7 +82,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/compat.h>
-#include <linux/mempolicy.h>
+#include <linux/types.h>
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
 
--- linux-2.6.15.5/arch/i386/mach-voyager/voyager_cat.c~	2006-03-02 18:55:47.000000000 +0100
+++ linux-2.6.15.5/arch/i386/mach-voyager/voyager_cat.c	2006-03-02 18:55:47.000000000 +0100
@@ -114,7 +114,6 @@ static struct resource qic_res = {
  * It writes num_bits of the data buffer in msg starting at start_bit.
  * Note: This function assumes that any unused bit in the data stream
  * is set to zero so that the ors will work correctly */
-#define BITS_PER_BYTE 8
 static void
 cat_pack(__u8 *msg, const __u16 start_bit, __u8 *data, const __u16 num_bits)
 {
--- linux-2.6.15.5/include/linux/types.h~	2006-03-02 18:54:57.000000000 +0100
+++ linux-2.6.15.5/include/linux/types.h	2006-03-02 18:54:57.000000000 +0100
@@ -8,6 +8,8 @@
 	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
+
+#define BITS_PER_BYTE 8
 #endif
 
 #include <linux/posix_types.h>



