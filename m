Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWDOFi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWDOFi4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 01:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWDOFi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 01:38:56 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:8424 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030257AbWDOFiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 01:38:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=p6G3d6TU0MmeL1zvbWjcwVpv4OwSpN4qhd0WBx685U/eDMZUFM4UAb8ODqMDVhRRcOYaGSbCLh56dFHt2Wfg1oPCt9KRV/+kg2vkYI8d91DaqTuU9HHsP1xuzKLXPp3FagFppD3MDzNn802RTTfTt5FVOgAD6SQWHN/bYwe55Mk=
Message-ID: <444086CB.2000700@gmail.com>
Date: Sat, 15 Apr 2006 13:38:19 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rpurdie@rpsys.net
Subject: [PATCH] fbdev: Fix return error of fb_write
References: <1145009768.6179.7.camel@localhost.localdomain>	<44404401.3030702@gmail.com> <20060414213105.09f0dd8d.akpm@osdl.org>
In-Reply-To: <20060414213105.09f0dd8d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix return code of fb_write():

If at least 1 byte was transferred to the device, return number of bytes,
otherwise:

    - return -EFBIG - if file offset is past the maximum allowable offset or
      size is greater than framebuffer length
    - return -ENOSPC - if size is greater than framebuffer length - offset

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> Richard Purdie wrote:
>>
>> - return -EFBIG if file offset is past the maximum allowable offset
> 
> OK.
> 
>> - return -EFBIG and write to end of framebuffer if size is bigger than the
>>   framebuffer length
> 
> We should return the number of bytes written in this case.
> 
>> - return -ENOSPC and write to end of framebuffer if size is bigger than the
>>   framebuffer length - file offset
> 
> Also here.
> 
> 
> If we can transfer _any_ bytes, we should do so, then return the number of
> bytes transferred.  If no bytes were transferrable then we should return
> -Ewhatever.
> 
> 

Okay, here's try #2:

 drivers/video/fbmem.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 944855b..a4b6776 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -669,13 +669,19 @@ fb_write(struct file *file, const char _
 		total_size = info->fix.smem_len;
 
 	if (p > total_size)
-		return 0;
+		return -EFBIG;
 
-	if (count >= total_size)
+	if (count > total_size) {
+		err = -EFBIG;
 		count = total_size;
+	}
+
+	if (count + p > total_size) {
+		if (!err)
+			err = -ENOSPC;
 
-	if (count + p > total_size)
 		count = total_size - p;
+	}
 
 	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
 			 GFP_KERNEL);
@@ -717,7 +723,7 @@ fb_write(struct file *file, const char _
 
 	kfree(buffer);
 
-	return (err) ? err : cnt;
+	return (cnt) ? cnt : err;
 }
 
 #ifdef CONFIG_KMOD
