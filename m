Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756045AbWKVRcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045AbWKVRcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756047AbWKVRcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:32:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:12510 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756045AbWKVRcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:32:32 -0500
Date: Wed, 22 Nov 2006 09:28:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Emelianov <xemul@openvz.org>
cc: Morton Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       Vivek Goyal <vgoyal@in.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>, dev@sw.ru
Subject: Re: 2.6.19-rc6: known regressions (v4)
In-Reply-To: <45641BEE.8060603@openvz.org>
Message-ID: <Pine.LNX.4.64.0611220924490.3457@woody.osdl.org>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
 <20061121212424.GQ5200@stusta.de> <20061121213335.GB30010@in.ibm.com>
 <Pine.LNX.4.64.0611211410460.3338@woody.osdl.org> <45641BEE.8060603@openvz.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Nov 2006, Pavel Emelianov wrote:
> 
> This works for me, but is this normal that desc's fields are
> modified non-atomically in note_interrupt()?

This is all inside the normal interrupt handling logic, so it should be 
exactly as safe as any interrupt is: we don't allow the _same_ interrupt 
to be entered recursively at the same time.

So yes, the counts etc are done non-atomically, but the code around it all 
guarantees that only one concurrent invocation happens per irq descriptor, 
so it's all ok.

(The one exception to that may be the "desc->status" modification in case 
the irq is determined to have screamed, since "status" can be modified by 
a recursive interrupt coming in, but (a) that's a "this irq is dead" 
schenario _anyway_ and (b) if we ever care, we should lock it _there_, not 
somewhere else).

			Linus
