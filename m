Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbTFSBdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbTFSBdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:33:21 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:13782 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id S265691AbTFSBdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:33:19 -0400
Message-ID: <3EF11662.2060102@oracle.com>
Date: Wed, 18 Jun 2003 18:48:18 -0700
From: Scot McKinley <scot.mckinley@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.0.1) Gecko/20020920 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Myers <jgmyers@netscape.com>
CC: Joel Becker <jlbec@evilplan.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH 2.5.71-mm1] aio process hang on EINVAL
References: <1055810609.1250.1466.camel@dell_ss5.pdx.osdl.net> <3EEE6FD9.2050908@netscape.com> <20030617085408.A1934@in.ibm.com> <1055884008.1250.1479.camel@dell_ss5.pdx.osdl.net> <3EEFAC58.905@netscape.com> <20030618001534.GJ7895@parcelfarce.linux.theplanet.co.uk> <3EEFB165.5070208@netscape.com> <20030618004214.GK7895@parcelfarce.linux.theplanet.co.uk> <3EF104D7.5050905@netscape.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > The kernel would have to be substantially more complex to report all
 > errors that could possibly be detected during queuing.

It doesn't have to report all of them...obviously the application CAN
handle async completions, otherwise it wouldn't be io_submit'ing aio.
However, for the one that it can report, it is a nice optimization TO
actually report them.

 > The kernel could
 > even detect success during queuing if it really tried.

Yes, this is also a good thing, as i mentioned in my earlier message.
ie, if the io has ALREADY completed, return it immediately.

 > This is not a reasonable requirement.  A correctly written program has
 > to be able to handle errors reported asynchronously.  Why else would
 > they be using an asynchronous API?

Yes, the program WILL be able to handle async completions, obviously, since
it attempting aio submissions. However, it MAY also be able to handle
synchronous/immediate completions of its aio submissions.

 > So?  That is a miniscule amount of resources used by an extremely rare
 > condition.  Such a picayune optimization hardly justifies the necessary
 > increase in complexity.

It may not be miniscule. As we expand the ability to do aio to network
descriptors, the transport that we are utilizing could easily have a
"bcopy threshold" (a bcopy thresheld, for those that don't know, is the
threshold under which all io will be done synchronously. ie, it MAY be
more efficient to actually copy the data, instead of doing async io,
if the data is small). Thus, all transfers below the bcopy threshold will
incur this extra queuing overhead (etc), even tho they have ALREADY
completed! This will be for the NORMAL io path, NOT an error condition.
Also, there is no need for the app to have keep this memory around til
the async completion is returned, if the io already completed synchronously
(either a synchronous error, or an immediate/synchronous *successful* io
operation). This memory could be substantial, if the presentation protocol
the app has to adhere to requires a substantial amount of small packets
and/or there all many connections being serviced.

