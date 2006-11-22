Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755523AbWKVHiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbWKVHiy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 02:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755530AbWKVHiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 02:38:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755523AbWKVHix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 02:38:53 -0500
Message-ID: <4563FE71.4040807@redhat.com>
Date: Tue, 21 Nov 2006 23:38:25 -0800
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
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <20061121184605.GA7787@2ka.mipt.ru>
In-Reply-To: <20061121184605.GA7787@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> I've checked the code.
> Since it will be a union, it is impossible to use _sigev_thread and it
> becomes just SIGEV_SIGNAL case with different delivery mechanism.
> Is it what you want?

struct sigevent is defined like this:

typedef struct sigevent {
         sigval_t sigev_value;
         int sigev_signo;
         int sigev_notify;
         union {
                 int _pad[SIGEV_PAD_SIZE];
                  int _tid;

                 struct {
                         void (*_function)(sigval_t);
                         void *_attribute;       /* really pthread_attr_t */
                 } _sigev_thread;
         } _sigev_un;
} sigevent_t;


For the SIGEV_KEVENT case:

   sigev_notify is set to SIGEV_KEVENT (obviously)

   sigev_value can be used for the void* data passed along with the
   signal, just like in the case of a signal delivery

Now you need a way to specify the kevent descriptor.  Just add

   int _kevent;

inside the union and if you want

   #define sigev_kevent_descr _sigev_un._kevent

That should be all.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
