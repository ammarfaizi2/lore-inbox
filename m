Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSJVLvo>; Tue, 22 Oct 2002 07:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262461AbSJVLvo>; Tue, 22 Oct 2002 07:51:44 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:15886 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262446AbSJVLvo>;
	Tue, 22 Oct 2002 07:51:44 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Christoph Hellwig <hch@sgi.com>
Cc: Piet Delaney <piet@www.piet.net>, "Matt D. Robinson" <yakker@aparity.com>,
       linux-kernel@vger.kernel.org, steiner@sgi.com,
       jeremy@classic.engr.sgi.com
Subject: Re: [PATCH] 2.5.44: lkcd (9/9): dump driver and build files 
In-reply-to: Your message of "Tue, 22 Oct 2002 14:47:45 -0400."
             <20021022144745.A7367@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Tue, 22 Oct 2002 21:57:35 +1000
Message-ID: <8948.1035287855@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002 14:47:45 -0400, 
Christoph Hellwig <hch@sgi.com> wrote:
>On Mon, Oct 21, 2002 at 03:06:59PM -0700, Piet Delaney wrote:
>> > Using volatile is almost always a bug.  USe atomic variables
>> > or bitops instead.
>> 
>> Yea, volatile is just being used to implement a simple atomic variable. 
>
>It just isn't guaranteed to be atomic.. Use atomic_t (for actual
>values) or unsigned long + set_bit/test_bit/ænd friends for bitmasks.

atomic_t is problematic for debugging code which can be invoked by an
error from any state.  On parisc, atomic_add is implemented using load
and clear on a hash of the lock address, so it is possible to get
collisions on locks when doing atomic ops from debugging code.
Especially when the parisc code in 2.5.44 has exactly one hash table
entry.  kdb has the same problem and tries to avoid atomic_t for the
same reason, the current state is unreliable.

The dump_in_progress flag is set in one place and cleared in another.
All the other uses of dump_in_progress are testing its state.  If
atomic_t cannot be used safely, then it must be defined as volatile.

