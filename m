Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933340AbWK0TVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933340AbWK0TVB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933351AbWK0TVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:21:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25040 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933340AbWK0TVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:21:00 -0500
Message-ID: <456B3A7C.20301@redhat.com>
Date: Mon, 27 Nov 2006 11:20:28 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru> <4564E162.8040901@redhat.com> <20061123115240.GA20294@2ka.mipt.ru> <4565FA60.9000402@redhat.com> <20061124110143.GF13600@2ka.mipt.ru> <456718A3.1070108@redhat.com> <20061124161406.GA5054@2ka.mipt.ru>
In-Reply-To: <20061124161406.GA5054@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:

> If kernel has put data asynchronously it will setup special flag, thus 
> kevent_wait() will not sleep and will return, so thread will check new
> entries and process them.

This is not sufficient.

The userlevel code does not commit the events until they are processed. 
  So assume two threads at userlevel, one event is asynchronously 
posted.  The first thread picks it up, the second call kevent_wait.

With your scheme it will not be put to sleep and unnecessarily returns 
to userlevel.

What I propose and what has been proven to work in many situations is to 
have part of the kevent_wait syscall the information about "I am aware 
of all events up to XX; wake me only if anything beyond that is added".

Please take a look at how futexes work, it's really the same concept. 
And it's really also simpler for the implementation.  Having such a flag 
is much more complicated than adding a simple index comparison before 
going to sleep.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
