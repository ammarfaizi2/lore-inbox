Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWINHYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWINHYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWINHYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:24:14 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:31492 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751397AbWINHYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:24:13 -0400
Message-ID: <4509039D.6000905@vmware.com>
Date: Thu, 14 Sep 2006 00:24:13 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, torvalds@osdl.org,
       jeremy@goop.org, mingo@elte.hu, ak@suse.de, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: Assignment of GDT entries
References: <787b0d920609132106p492cc990na471484d7dee8afb@mail.gmail.com>	 <m11wqf12hh.fsf@ebiederm.dsl.xmission.com>	 <787b0d920609132319y660c62c5rc245843aa55fd615@mail.gmail.com>	 <4508F680.8030501@vmware.com> <787b0d920609140012i220a189es68d077f3c67c68e2@mail.gmail.com>
In-Reply-To: <787b0d920609140012i220a189es68d077f3c67c68e2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote
>>
>> There are only 32 possible GDT entries in 32-bit i386 Linux, and only
>> three of them are usable for userspace.  You can't find out which slots
>> are in use, but you can cause one to be allocated and returned to you.
>> This seems like a perfectly reasonable API to me, why do you think it is
>> so ugly?
>
> Eh, "returned to you" doesn't work for me. I need to
> figure out what other code (not written by me) uses.

I don't understand.  Why do you need to figure that out?  You need a 
selector, you ask for one, and you get assigned one.  It is that 
simple.  You can't figure out what other code uses, and the kernel has 
no way to tell you, because that is an application level allocation 
problem, not a kernel responsibility.  The kernel has no visibility into 
userspace intentions regarding segment usage.

> I may need to "borrow" a slot if all three slots are in
> use. Without using evil knowledge of the GDT, how
> am I to do that? I don't know what slots might have
> been allocated by other libraries.

What kind of libraries are you using?  Unless this is really, really, 
special purpose, they are going to allocate at most one, and that is 
only if you use TLS libraries.

If all three slots are in use (i.e. your allocation fails), you'll have 
to allocate an LDT selector, just like wine:

void wine_ldt_init_fs( unsigned short sel, const LDT_ENTRY *entry )
{
    if ((sel & ~3) == (global_fs_sel & ~3))
    {
#ifdef __linux__
        struct modify_ldt_s ldt_info;
        int ret;

        ldt_info.entry_number = sel >> 3;
        fill_modify_ldt_struct( &ldt_info, entry );
        if ((ret = set_thread_area( &ldt_info ) < 0)) perror( 
"set_thread_area" );
#elif defined(__APPLE__)
        int ret = thread_set_user_ldt( wine_ldt_get_base(entry), 
wine_ldt_get_limit(entry), 0 );
        if (ret == -1) perror( "thread_set_user_ldt" );
        else assert( ret == global_fs_sel );
#endif  /* __APPLE__ */
    }
    else  /* LDT selector */
    {
        internal_set_entry( sel, entry );  <---- just like this
    }
    wine_set_fs( sel );
}

Zach
