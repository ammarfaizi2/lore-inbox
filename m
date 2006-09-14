Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWING3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWING3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 02:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWING3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 02:29:22 -0400
Received: from gw.goop.org ([64.81.55.164]:51172 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751368AbWING3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 02:29:20 -0400
Message-ID: <4508F6B9.1040709@goop.org>
Date: Wed, 13 Sep 2006 23:29:13 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, torvalds@osdl.org,
       mingo@elte.hu, ak@suse.de, arjan@infradead.org, zach@vmware.com,
       linux-kernel@vger.kernel.org
Subject: Re: Assignment of GDT entries
References: <787b0d920609132106p492cc990na471484d7dee8afb@mail.gmail.com>	 <m11wqf12hh.fsf@ebiederm.dsl.xmission.com> <787b0d920609132319y660c62c5rc245843aa55fd615@mail.gmail.com>
In-Reply-To: <787b0d920609132319y660c62c5rc245843aa55fd615@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> So if I grabbed the first two slots before glibc got to
> mess with them, glibc wouldn't break horribly?

glibc would be happy with anything it got; if you grabbed all 3 TLS 
slots it would probably be upset.

> If I grabbed one slot and glibc grabbed another, Wine
> would be OK with the third instead of the second?

Presumably.

> So basically it's not allowed to just grab the 3rd slot?
Eh?  You mean there's no "allocate and return TLS slot #N" operation?  
No, but all the TLS slots should be interchangeable.  Once you've got 
your entry numbers and worked out your selector values, you can just use 
them.

> What if I want to find out what is already in use?
> Am I supposed to iterate over all 8191 possible
> GDT entries? How do I even tell how many slots
> are available without using them all up?
The kernel reserves 3 slots in the GDT for usermode use, which are 
per-thread.  If you want more segment descriptors, you can always 
allocate an LDT.

> Eeeeeeew. Well this was documented exactly nowhere.
> The man page is even vague about entry_number,

man set_thread_area has this as paragraph 2:

       When  set_thread_area() is passed an entry_number of -1, it uses a free
       TLS entry. If set_thread_area() finds a free TLS entry,  the  value  of
       u_info->entry_number  is  set  upon  return  to  show  which  entry was
       changed.

which seems pretty clear to me.  A quick run with strace on any binary 
shows this in action:

    set_thread_area({entry_number:-1 -> 6, base_addr:0xb7fb06c0,
    limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
    limit_in_pages:1, seg_not_present:0, useable:1}) = 0

    J
