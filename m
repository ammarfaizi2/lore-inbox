Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTHZKhc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 06:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTHZKhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 06:37:31 -0400
Received: from holomorphy.com ([66.224.33.161]:40366 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263631AbTHZKha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 06:37:30 -0400
Date: Tue, 26 Aug 2003 03:38:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-ID: <20030826103833.GX1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Muli Ben-Yehuda <mulix@mulix.org>,
	Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@redhat.com>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20030825231449.7de28ba6.akpm@osdl.org> <Pine.LNX.4.44.0308260233550.20822-100000@devserv.devel.redhat.com> <20030826000218.2ceaea1d.akpm@osdl.org> <1061884611.2982.4.camel@laptop.fenrus.com> <20030826080759.GK13390@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826080759.GK13390@actcom.co.il>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 11:08:00AM +0300, Muli Ben-Yehuda wrote:
> How about combining something that's shared to all of the threads that
> share a futex but not system wide (the mm?) with something simple that
> won't change, like the page offset? Adding the mm into the mix wil
> make collisions harder, and limiting the buckets to the number of
> different futex offsets will make it simple and differentiate between
> different futexes in the same mm. 

The mm is not the sharing boundary; it can be shared along the usual
sharing boundaries; hence we have the usual two cases:

(a) shared between all those mmap()'ing some inode for file-backed memory
	Can be handled by embedding it into a struct address_space.
(b) shared between all fork()'s between exec()'s for anonymous memory
	Can be handled by embedding it in some new object representing
	all fork()'s between exec()'s.
(c) anonymous pages formerly owned by inodes orphaned by truncate().
	This is hard.

The containing object (for (a) and (b)) can be located with a back
pointer from the futex, except you have the usual intractable disaster
whenever file-backed pages are anonymized via truncate().


-- wli
