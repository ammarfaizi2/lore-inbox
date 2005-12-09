Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVLIEvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVLIEvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 23:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVLIEvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 23:51:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34991 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751280AbVLIEvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 23:51:12 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Alan Stern <stern@rowland.harvard.edu>, sekharan@us.ibm.com, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/7]: Fix for unsafe notifier chain 
In-reply-to: Your message of "Wed, 07 Dec 2005 15:36:12 -0800."
             <20051207153612.0de2ce38.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 09 Dec 2005 15:50:46 +1100
Message-ID: <7821.1134103846@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005 15:36:12 -0800, 
Andrew Morton <akpm@osdl.org> wrote:
>As for the NMIs and RCU: I suspect it was simply a mistake to try to use
>notifier chains for NMI registration in the first place - they are simply
>too complex a data structure for this.  I think I previously suggested
>removing that code and using just a fixed-size array of function pointers.

The notifier chain is a priority ordered list.  Registration and
unregistration must be able to insert and delete anywhere in the list,
which does not fit with a fixed-size array of pointers.

There is also the problem that unregister must not return to its caller
if any NMI type callback is running on any cpu.  The list and function
body are held in caller defined storage and if unregistration returns
too soon then the storage could be freed while the callback is still
executing.

I do not understand why people think that NMI callbacks are a hard
problem to solve.  Besides RCU type solutions, there is also a patch
based on an idea by Corey Minyard, see
http://marc.theaimsgroup.com/?l=linux-kernel&m=113392370322545&w=2.

