Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWJWAZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWJWAZe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 20:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWJWAZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 20:25:34 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:36430 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1750953AbWJWAZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 20:25:33 -0400
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: Hopefully, kmalloc() will always succeed, but if it doesn't then....
X-Message-Flag: Warning: May contain useful information
References: <20061022230957.78480.qmail@web55615.mail.re4.yahoo.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 22 Oct 2006 17:25:30 -0700
In-Reply-To: <20061022230957.78480.qmail@web55615.mail.re4.yahoo.com> (Amit Choudhary's message of "Sun, 22 Oct 2006 16:09:56 -0700 (PDT)")
Message-ID: <adalkn7j2th.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Oct 2006 00:25:31.0467 (UTC) FILETIME=[BF98D1B0:01C6F639]
Authentication-Results: sj-dkim-8.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >         struct mixart_enum_connector_resp *connector;
 >         struct mixart_audio_info_req  *audio_info_req;
 >         struct mixart_audio_info_resp *audio_info;
 > 
 >         connector = kmalloc(sizeof(*connector), GFP_KERNEL);
 >         audio_info_req = kmalloc(sizeof(*audio_info_req), GFP_KERNEL);
 >         audio_info = kmalloc(sizeof(*audio_info), GFP_KERNEL);
 >         if (! connector || ! audio_info_req || ! audio_info) {
 >                 err = -ENOMEM;
 >                 goto __error;
 >         }

This is not a bug.  All of the pointers are initialized, and if
kmalloc() fails, then one of them will be set to NULL.  However,
kfree(NULL) is a perfectly fine thing to do (kfree just returns
immediately in this case).

So this is just a way of saving some tests and optimizing for the
common case when all allocations succeed.  In other words, this is
good code -- although the spacing is slightly bogus: it should be

        if (!connector || !audio_info_req || !audio_info) {

and also using __error as a label is slightly silly -- why not just
make it "error"?

 - R.
