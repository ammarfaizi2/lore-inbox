Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265291AbUE0V3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUE0V3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbUE0V3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:29:08 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:51344 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S265291AbUE0V3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:29:04 -0400
Message-ID: <40B65C14.6070705@linuxmail.org>
Date: Fri, 28 May 2004 07:22:28 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP support for drain local pages v2.
References: <40B473F7.4000100@linuxmail.org> <20040526223255.GB15278@redhat.com> <40B520A2.2060508@linuxmail.org> <20040526162607.0f177009.akpm@osdl.org> <40B52A7D.6090102@linuxmail.org> <20040527192956.GD509@openzaurus.ucw.cz>
In-Reply-To: <20040527192956.GD509@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Andrew, Dave: do you want to be cc'd still?

Pavel Machek wrote:
> drain_local_pages was there so that accounting is not
> screwed by local pages. That should be non-issue for stopped cpus.

You're probably right that it's not absolutely necessary. That said, I have three reasons for 
wanting to do it: each cpu has say 200 pages in its pcp structs (this varies with zone size). If we 
don't drain them, we're saving 200 extra pages (because they're not marked as free). That's fine for 
a dual CPU system, but it's not very scalable. (I admit I wouldn't want to suspend to disk a 4GB 
machine now, but in the future?).

More than that, though, my real motivation is to be able to account for every page in the system and 
ensure that suspend is doing the right thing with all of them. If I drain the PCP page lists, I can 
be more certain that allocations do come from the right place.

Thirdly, after suspending hot pages aren't really hot anymore. We may as well start with clean lists.

> 
> OTOH you are right that my swsusp with smp does not work
> on my smp machine, and I do not yet know why.

I found that I needed to:
- save context for other CPUs.
- ensure they're completely idle during copyback even running the idle thread messed things up (use 
a smp function)
- ensure suspend is always running on CPU0 (at the start of suspending and resuming)

You might also consider how you're restoring highmem pages and how that interacts with SMP esp in 
flushing tlbs.

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur
with alarming frequency, order arises from chaos, and no one is given credit.
