Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVK0P7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVK0P7S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 10:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVK0P7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 10:59:18 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:46534 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751096AbVK0P7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 10:59:17 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       paulmck@us.ibm.com, greg@kroah.com, Douglas_Warzecha@dell.com,
       Abhay_Salunke@dell.com, achim_leubner@adaptec.com,
       dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain 
In-reply-to: Your message of "Sun, 27 Nov 2005 14:47:36 BST."
             <20051127134735.GK31722@brahms.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 28 Nov 2005 02:59:05 +1100
Message-ID: <22267.1133107145@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2005 14:47:36 +0100, 
Andi Kleen <ak@suse.de> wrote:
>akpm wrote
>>   - Introduce a new notifier API which is wholly unlocked
>
>The old notifiers were already wholly unlocked. So it wouldn't 
>even need any changes. Just additional locks everywhere.

Wrong.  The existing implementation is racy as hell.  There is NO
locking on the existing chains, these patches make the notifier chains
race free.

Some of the notifier callbacks are used in weird contexts, including
NMI, so the only option for those chains is RCU.  Obviously those
callbacks cannot sleep.  Other chains are used in more normal context
_AND_ the callbacks want to sleep, so those chains need to use sleeping
locks.

