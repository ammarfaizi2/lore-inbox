Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVDEWlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVDEWlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 18:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVDEWlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 18:41:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18318 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261880AbVDEWlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 18:41:23 -0400
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please check)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       vherva@viasys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       hifumi.hisashi@lab.ntt.co.jp, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050330115946.GA7331@logos.cnet>
References: <20050326162801.GA20729@logos.cnet>
	 <20050328073405.GQ16169@viasys.com> <20050328165501.GR16169@viasys.com>
	 <16968.40186.628410.152511@cse.unsw.edu.au>
	 <20050329215207.GE5018@logos.cnet>
	 <16970.9679.874919.876412@cse.unsw.edu.au>
	 <20050330115946.GA7331@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 05 Apr 2005 23:40:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-03-30 at 12:59, Marcelo Tosatti wrote:

> > I'm not certain that this is right, but it seems possible and would
> > explain the symptoms.  Maybe Stephen or Andrew could comments?
> 
> Andrew, Stephen?

Sorry, was offline for a week last week; I'll try to look at this more
closely tomorrow.  Checking the buffer_uptodate() without either a
refcount or a lock certainly looks unsafe at first glance.

There are lots of ways to pin the bh in that particular bit of the
code.  The important thing will be to do so without causing leaks if
we're truly finished with the buffer after this flush.


> > If some of the write succeeded and some failed, then I believe the
> > correct behaviour is to return the number of bytes that succeeded.
> > However this change to the return status (remember the above patch is
> > a reversal) causes any failure to over-ride any success. This, I
> > think, is wrong.
> 
> Yeap, that part also looks wrong.

Certainly it's normal for a short read/write to imply either error or
EOF, without the error necessarily needing to be returned explicitly. 
I'm not convinced that the Singleunix language actually requires that,
but it seems the most obvious and consistent behaviour.

--Stephen

