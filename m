Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264078AbTKSOWk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 09:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264084AbTKSOWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 09:22:40 -0500
Received: from holomorphy.com ([199.26.172.102]:55977 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264078AbTKSOWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 09:22:38 -0500
Date: Wed, 19 Nov 2003 06:22:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Ronny V. Vindenes" <s864@ii.uib.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4 - kernel BUG at arch/i386/mm/fault.c:357!
Message-ID: <20031119142230.GX22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1069246427.5257.12.camel@localhost.localdomain> <20031119130220.GT22764@holomorphy.com> <1069248455.5257.26.camel@localhost.localdomain> <20031119140222.GV22764@holomorphy.com> <1069251503.3390.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069251503.3390.1.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 03:18:23PM +0100, Ronny V. Vindenes wrote:
> bad nopage snd_pcm_mmap_data_nopage+0x0/0xc0 [snd_pcm]
> handle_mm_fault() returned bad status


diff -prauN mm4-2.6.0-test9-1/sound/core/pcm_native.c mm4-2.6.0-test9-dbg-1/sound/core/pcm_native.c
--- mm4-2.6.0-test9-1/sound/core/pcm_native.c	2003-11-19 00:07:16.000000000 -0800
+++ mm4-2.6.0-test9-dbg-1/sound/core/pcm_native.c	2003-11-19 06:20:32.000000000 -0800
@@ -2819,7 +2819,7 @@ int snd_pcm_mmap_status(snd_pcm_substrea
 	return 0;
 }
 
-static struct page * snd_pcm_mmap_control_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
+static struct page * snd_pcm_mmap_control_nopage(struct vm_area_struct *area, unsigned long address, int *type)
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	snd_pcm_runtime_t *runtime;
@@ -2831,6 +2831,8 @@ static struct page * snd_pcm_mmap_contro
 	page = virt_to_page(runtime->control);
 	if (!PageReserved(page))
 		get_page(page);
+	if (type)
+		*type = VM_FAULT_MINOR;
 	return page;
 }
 
@@ -2869,7 +2871,7 @@ static void snd_pcm_mmap_data_close(stru
 	atomic_dec(&substream->runtime->mmap_count);
 }
 
-static struct page * snd_pcm_mmap_data_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
+static struct page * snd_pcm_mmap_data_nopage(struct vm_area_struct *area, unsigned long address, int *type)
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	snd_pcm_runtime_t *runtime;
@@ -2897,6 +2899,8 @@ static struct page * snd_pcm_mmap_data_n
 	}
 	if (!PageReserved(page))
 		get_page(page);
+	if (type)
+		*type = VM_FAULT_MINOR;
 	return page;
 }
 
