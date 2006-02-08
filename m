Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWBHPgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWBHPgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWBHPgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:36:39 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:62932 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030431AbWBHPgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:36:38 -0500
Subject: Re: [PATCH] add execute_in_process_context() API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun <htejun@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <43EA0E7D.3030302@gmail.com>
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com.suse.lists.linux.kernel>
	 <p737j86l1es.fsf@verdi.suse.de>
	 <1139411751.3003.1.camel@mulgrave.il.steeleye.com>
	 <43EA0E7D.3030302@gmail.com>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 09:36:33 -0600
Message-Id: <1139412994.3003.10.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 00:30 +0900, Tejun wrote:
> I haven't really looked at the code carefully, but I think one work 
> struct + atomic counter (say pending_reap_cnt) should do it. 
> queue_work() guarantees the work is run at least once after the call, so 
> bumping pending_reap_cnt and queueing the work in target reap and 
> reaping pending_reap_cnt times in the work should work.

Actually, no, unfortunately that doesn't work (and I did actually try
it).  The problem is that the target_reap actually removes the target
from the sysfs namespace.  So, if the reap is still pending but you
cannot find the target, you'll allocate one, but then you may be racing
to add it to the namespace (i.e. a quick succession of scsi
remove-single-device followed by scsi add-single-device of the same
H/C/T/L shows this).  If you lose the race, the add fails because the
namespace is already occupied.  And, unfortunately, the device_del that
does the namespace removal requires user context ...

James


