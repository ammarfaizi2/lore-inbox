Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266378AbUG0JGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266378AbUG0JGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUG0JGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:06:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:41413 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266380AbUG0JGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:06:24 -0400
Message-ID: <41061AC0.8000607@suse.de>
Date: Tue, 27 Jul 2004 11:05:04 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit number of concurrent hotplug processes
References: <40FD23A8.6090409@suse.de>	<20040725182006.6c6a36df.akpm@osdl.org>	<4104E421.8080700@suse.de>	<20040726131807.47816576.akpm@osdl.org>	<4105FE68.7040506@suse.de>	<20040727002409.68d49d7c.akpm@osdl.org>	<41060B62.1060806@suse.de> <20040727013427.52d3e5f5.akpm@osdl.org>
In-Reply-To: <20040727013427.52d3e5f5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Hannes Reinecke <hare@suse.de> wrote:
> 
>> Patch (for the semaphore version) is attached.
> 
> 
> err, what on earth is this patch trying to do?  It adds tons more
> complexity then I expected to see.  Are the async (wait=0) semantics for
> call_usermodehelper() preserved?
> 
Problem with your patch is that call_usermodehelper might block on 
down() regardless whether it is called async or sync.
So any write to sysfs which triggers a hotplug event might block until 
enough resources are available.

Most complexity is in fact due to the possibility to change khelper_max 
on the fly. If we disallow that everything else will be far cleaner.

> Why is the code now doing
> 
> 	if (stored_info.wait > 0) {
> and
> 	if (stored_info.wait >= 0) {
> 
> ?  `wait' is a boolean.  Or did its semantics get secretly changed somewhere?
> 
> Why is a new kernel thread needed to up and down a semaphore?
> 
As I said; down() might block. Unless we accept that the caller will 
only return after all down()s have been executed successfully we need 
something like that.

> Sorry, but I've completely lost the plot on what you're trying to do here!
> 
Sorry for this. I've probably pushed too hard for this.

I'll wrap up a patch which only allows for a static setting (via kernel 
command line parameters) and leave the on-the-fly setting for later :-).

> 
> I'd have though that something like the below (untested, slightly hacky)
> patch would suit.
> 
Indeed, but only if we accept that any call to call_usermodehelper might 
block if not enough resources are available.

THX for the patch, btw.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
