Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266685AbUGQCMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266685AbUGQCMs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 22:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUGQCMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 22:12:48 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:44484 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S266685AbUGQCMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 22:12:46 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Chris Wright <chrisw@osdl.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: Re: [RFC] Lock free fd lookup 
In-reply-to: Your message of "Fri, 16 Jul 2004 18:19:36 MST."
             <20040717011936.GK3411@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Jul 2004 12:12:39 +1000
Message-ID: <3310.1090030359@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2004 18:19:36 -0700, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>On Sat, Jul 17, 2004 at 10:55:59AM +1000, Keith Owens wrote:
>> 2-3-4 trees are self balancing, which gave decent lookup performance.
>> Since red-black trees are logically equivalent to 2-3-4 trees it should
>> be possible to use lockfree red-black trees.  However I could not come
>> up with a lockfree red-black tree, mainly because an read-black insert
>> requires atomic changes to multiple structures.  The 2-3-4 tree only
>> needs atomic update to one structure at a time.
>
>This actually appears to confirm my earlier assertion about the linkage
>of the data structure. Is this conclusion what you had in mind?

Not quite.  The 2-3-4 tree has embedded linkage, but it can be done
lockfree if you really have to.  The problem is that a single 2-3-4
list entry maps to two red-black list entries.  I could atomically
update a single 2-3-4 list entry, including its pointers, even when the
list was being read or updated by other users.  I could not work out
how to do the equivalent update when the list linkage data was split
over two red-black nodes.

The list structure is an implementation detail, the use of 2-3-4 or
red-black is completely transparent to the main code.  The main code
wants to lookup a structure from the list, to update a structure, to
insert or to delete a structure without waiting.  How the list of
structures is maintained is a problem for the internals of the API.

