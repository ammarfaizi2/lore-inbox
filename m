Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263863AbTDVVlu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 17:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTDVVlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 17:41:50 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:50907 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263863AbTDVVlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 17:41:49 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16037.47541.643693.126049@lepton.softprops.com>
Date: Tue, 22 Apr 2003 16:52:53 -0500
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Tom Zanussi'" <zanussi@us.ibm.com>,
       "'karim@opersys.com'" <karim@opersys.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] printk subsystems
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C263A3B@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780C263A3B@orsmsx116.jf.intel.com>
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trimmed the cc list to those of us still here...

Perez-Gonzalez, Inaky writes:
 > 
 > 
 > > From: Tom Zanussi [mailto:zanussi@us.ibm.com]
 > > 
 > > In relayfs, the event can be generated directly into the space
 > > reserved for it - in fact this is exactly what LTT does.  There aren't
 > > two separate steps, one 'generating' the event and another copying it
 > > to the relayfs buffer, if that's what you mean.
 > 
 > In this case, what happens if the user space, through mmap, copies
 > while the message is half-baked (ie, from another CPU) ... won't it
 > be inconsistent?
 > 

There's a count kept, per sub-buffer, that's updated after each write.
If this count doesn't match the expected size of the sub-buffer, the
reader can ignore the incomplete buffer and come back to it later.
The count is maintained automatically by relay_write(); if you're
writing directly into the channel as LTT does though, part of the task
is to call relay_commit() after the write, which updates the count and
maintains consistency.

 > > Well, I'm not sure I understand the details of kue all that well, so
 > > let me know if I'm missing something, but for kue events to really be
 > > self-contained, wouldn't the data need to be copied into the event
 > > unless the data structure containing them was guaranteed to exist
 > > until the event was disposed of one way or another?
 > 
 > Yes, you have to guarantee the existence of the event data structures
 > (the 'struct kue', the embedded 'struct kue_user' and the event data
 > itself); if they are embedded into another structure that will dissa-
 > pear, you can choose to:
 > 
 > (a) recall the event [if it is recallable or makes sense to do so]
 > (b) dynamically allocate the event header and data, generate it 
 >     into that dynamic space.
 > (c) dynamically allocate and copy [slow]
 > 
 > (this works now; however, once I finish the destructor code, it
 > will give you the flexibility to use other stuff than just kmalloc()).
 > 
 > You can play many tricks here, but that depends on your needs,
 > requirements and similar stuff.
 > 

Well, kmalloc() seems like the most straightforward and convenient way
of managing space for all these individual events, if not the most
efficient.  Are you thinking that sub-allocating them out of a larger
buffer might make more sense, for instance?  If so, I'd suggest
relayfs for that. ;-) Just kidding, but it does seem you'll have a
certain amount of bookkeeping overhead and will need to deal with
things like fragmentation if you're going to manage a private memory
pool for everything.

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

