Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWDUQkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWDUQkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDUQkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:40:31 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:26594 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750743AbWDUQka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:40:30 -0400
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Michael Holzheu <HOLZHEU@de.ibm.com>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, penberg@gmail.com
In-Reply-To: <1145633898.13191.9.camel@localhost>
References: <OF5500FC25.13788C4B-ON42257157.004C98F0-42257157.004DB206@de.ibm.com>
	 <1145633898.13191.9.camel@localhost>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 21 Apr 2006 18:40:29 +0200
Message-Id: <1145637630.6884.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 18:38 +0300, Pekka Enberg wrote:
> Hi Michael,
> 
> On Fri, 2006-04-21 at 16:08 +0200, Michael Holzheu wrote:
> > The first one was, that the hardware interface for getting the data is
> > very expensive. We always get back the data for all LPARs and all
> > cpus. Therefore we do not want to get the data every time an attribute
> > file is read.
> 
> You can cache the results in userspace. So I don't see this one as an
> argument for making the kernel more complex.

Unfortunately we can't cache them in user-space. To read a file you do
open/read/close an the attributes you are interested in. If we do not
cache the content of the attributes in the kernel we have to issue a
diag204 for each open/read/close sequence. But the data that is deliverd
by diag204 will have changed between the two calls. In addition the
number of active lpars and the lpar names might have changed.

> On Fri, 2006-04-21 at 16:08 +0200, Michael Holzheu wrote:
> > The second problem was, that we want to provide a consistent snapshot
> > of the hypervisor data for the user space application.
> 
> How do you ensure consistency now? And how is that different from an
> userspace process reading the whole directory hierarchy into cache in
> one go?

We ensure the consistency by the following sequence:
1) read the update attribute to get the timestamp of the last update
2) decide if the data is new enough, if it is to old write something to
the update attribute and restart with 1)
3) read the information you are interested in
4) read the update attribute again and compare it with the one read in
step 1). If the timestamp has changed restart the whole thing with 1)

> The update-on-write to special file thing seems bit strange to me. What
> if two processes ask for it at the same time?

Yes, we had that discussion as well. Any sensible suggestion how to do
it in a more clever way would be greatly appreciated. We haven't found
something better so far.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


