Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266893AbUG1MSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266893AbUG1MSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 08:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUG1MSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 08:18:37 -0400
Received: from services.exanet.com ([212.143.73.102]:62197 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S266893AbUG1MSQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 08:18:16 -0400
Message-ID: <41079986.7090406@exanet.com>
Date: Wed, 28 Jul 2004 15:18:14 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com> <20040727203438.GB2149@elf.ucw.cz> <Pine.LNX.4.58.0407281402020.26456@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.58.0407281402020.26456@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jul 2004 12:18:15.0191 (UTC) FILETIME=[F5458270:01C4749C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:

>Hi!
>
>And if the NFS server is waiting for some lock that is held by another
>process that is wating for kswapd...? It won't help.
>
>The solution would be a limit for dirty pages on NFS --- if you say that
>less than 1/8 of memory might be dirty NFS pages, than you can keep system
>stable even if NFS writes starve. If you export NFS filesystem via NFSD
>again, even this woudn't help, but there's no fix for this case.
>
>  
>
Oh yes there is. You can have different limits for each export, with the 
nested export having a lower limit.

Say the first export may dirty at most 200MB, and the nested export at 
most 180MB. So even if there are heavy writes against the nested export, 
it can always make progress by writing to the outer export, and if the 
system has more than 200MB of memory, the external export can make 
progress by writing out to the filesystem.

That is essentially my suggestion regarding reservation levels, but 
expressed in allocate-at-most terms instead of leave-at-least. And 
nested NFS is a fine example to show the current problems.

(of course, when nesting NFS one also needs to reserve threads so each 
export has at least one thread available to service it. but that's 
another story)

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


