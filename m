Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933080AbWF2Wy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933080AbWF2Wy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933081AbWF2Wy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:54:58 -0400
Received: from mx03.cybersurf.com ([209.197.145.106]:20183 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S933080AbWF2Wy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:54:57 -0400
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, pj@sgi.com, Valdis.Kletnieks@vt.edu,
       jlan@engr.sgi.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <44A43187.3090307@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	 <449999D1.7000403@engr.sgi.com>	<44999A98.8030406@engr.sgi.com>
	 <44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>
	 <449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>
	 <449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>
	 <449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>
	 <449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>
	 <20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>
	 <20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>
	 <20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>
	 <20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>
	 <20060629014050.d3bf0be4.pj@sgi.com>
	 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	 <20060629094408.360ac157.pj@sgi.com>
	 <20060629110107.2e56310b.akpm@osdl.org>	<44A425A7.2060900@watson.ibm.com>
	 <20060629123338.0d355297.akpm@osdl.org>  <44A43187.3090307@watson.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Thu, 29 Jun 2006 18:54:52 -0400
Message-Id: <1151621692.8922.4.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-29-06 at 16:01 -0400, Shailabh Nagar wrote:

> 
> Jamal,
> any thoughts on the flow control capabilities of netlink that apply here 
> ? Usage of the connection is to supply statistics data to userspace.
> 

if you want reliable delivery, then you cant just depend on async events
from the kernel -> user - which i am assuming is the way stats get
delivered as processes exit? Sorry, i dont remember the details. You
need some synchronous scheme to ask the kernel to do a "get" or "dump".

Lets be clear about one thing:
The problem really has nothing to do with gen/netlink or any other
scheme you use;->
It has everything to do with reliability implications and the fact
that you need to assume memory is a finite resource - at one point
or another you will run out of memory ;-> And of course then messages
will be lost.  So for gen/netlink, just make sure you have large socket
buffer and you would most likely be fine. 
I havent seen how the numbers were reached: But if you say you receive
14K exits/sec each of which is a 50B message, I would think a 1M socket
buffer would be plenty.

You can find out about lack of memory in netlink when you get a ENOBUFS.
As an example, you should then do a kernel query. Clearly if you do a
query of that sort, you may not want to find obsolete info. Therefore,
as a suggestion, you may want to keep sequence numbers of sorts as
markers. Perhaps keep a 32-bit field which monotically increases per
process exit or use the pid as the sequence number etc..

As for throttling - Shailabh, I think we talked about this:
- You could maintain info using some thresholds and timer. Then
when a timer expires or threshold is exceeded send to user space.

BTW, where is the doc fixes ? ;->

cheers,
jamal


