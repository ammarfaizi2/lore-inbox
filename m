Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVGMA1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVGMA1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVGMA1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:27:18 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54666 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261790AbVGMA1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:27:16 -0400
X-Sasl-enc: 1xKbIxz3blNV3aZj9BtXoGFBLdwilYqu4Z+8OPbwbzNW 1121214430
Message-ID: <039301c58741$a4df9fb0$7c00a8c0@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Lars Roland" <lroland@gmail.com>, "Bron Gondwana" <brong@fastmail.fm>
Cc: <linux-kernel@vger.kernel.org>, "Jeremy Howard" <jhoward@fastmail.fm>,
       "Chris Mason" <mason@suse.com>, "Vladimir Saveliev" <vs@namesys.com>
References: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP> <4ad99e05050712024319bc7ada@mail.gmail.com> <021801c586d7$5ebf4090$7c00a8c0@ROBMHP> <4ad99e05050712051341cf6e3@mail.gmail.com> <1121176268.15213.238283120@webmail.messagingengine.com> <4ad99e0505071209372176f625@mail.gmail.com>
Subject: Re: 2.6.12.2 dies after 24 hours
Date: Wed, 13 Jul 2005 10:27:10 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > We're also applying the attached patch.  There's a bug in reiserfs that
> > gets tickled by our huge MMAP usage (it's amazing what really busy
> > Cyrus daemons can do to a server, ouch).  It's fixed in generic_write,
> > so we take the few percent performance hit for something that doesn't
> > break!
>
> Interesting - When I got the problem it was on mail servers under high
> load (handling 60.000 emails pr. hour) with reiserfs as file system. I
> have seen this problem on 5 different servers so I am confident that
> it is not hardware failure.
>
> Sometimes the server load just rises and then the server dies other
> times the load rises but the kernel manages to get it back alive
> filling up syslog with messages like this

Sounds like a different issue. The patch Bron included before fixes (or at 
least reduces to the point where it fixes it for us) a problem where 
processes get stuck in D state and are unkillable. A reboot is required to 
remove them. Apparently this is a known bug in ReiserFS (see messages 
below). As noted, the same bug exists in ext3. There appears to have been 
some patches to try and fix it for both reiserfs and ext3, but I'm not sure 
if they're in the mainline kernel yet.

http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/2056.html
http://hulllug.principalhosting.net/archive/index.php/t-22774.html

Rob

----- Original Message ----- 
From: "Vladimir Saveliev" <vs@namesys.com>
To: "Jeremy Howard" <jhoward@fastmail.fm>
Cc: "Hans Reiser" <reiser@namesys.com>; <reiserfs-dev@namesys.com>
Sent: Friday, October 08, 2004 4:57 PM
Subject: Re: URGENT: Need fix for problem with copy_from_user inside a 
transaction


> Hello
>
> On Thu, 2004-10-07 at 21:35, Jeremy Howard wrote:
>> On Fri, 01 Oct 2004 09:13:34 -0700, "Hans Reiser" <reiser@namesys.com>
>> said:
>> > Chris, can you comment please?
>>
>> Also... can you guys suggest any ways to minimise the problem, e.g.
>> external vs internal journal? metadata vs full journalling? changing the
>> elevator? ...
>
> Would you please check whether the attached patch for
> ./fs/reiserfs/file.c fixes the problem?
>
> Quick benchmark shows that using generic_file_write does not hurt
> reiserfs performance too much comparing to using original
> reiserfs_file_write.
>
>                            ---Sequential Output (nosync)--- ---Sequential 
> Input-- --Rnd Seek-
>                            -Per Char- --Block--- -Rewrite-- -Per 
> Char- --Block--- --04k (03)-
>                         MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU 
> K/sec %CPU   /sec %CPU
> generic_file_write      256 16690 99.7 28332 29.9 11528 16.8 12411 77.2 
> 28888 17.3  237.4  2.1
> reiserfs_file_write     256 15647 86.8 30875 22.1 10822 14.1 11631 72.1 
> 29184 16.1  250.0  2.0
>
>
>>
>> > Vladimir Saveliev wrote:
>> >
>> > >Hello
>> > >
>> > >On Fri, 2004-10-01 at 01:53, Hans Reiser wrote:
>> > >
>> > >
>> > >>vs, this is not enough of an answer to share your understanding of 
>> > >>the
>> > >>problem.  Please say much more.
>> > >>
>> > >>
>> > >
>> > >Reiserfs_write_file locks set of pages, and then tries to copy data to
>> > >them. If it is to copy data from one of pages which are locked and if
>> > >that page is not uptodate, pagefault requires to lock that page, but 
>> > >as
>> > >it is locked already - process deadlocks with itself.
>> > >
>> > >
>> > Is this when copying from one file in a formatted node to another file
>> > in that node?
>> >
>> > >As Chris said - fix is not trivial. Also, it is known that he did
>> > >already something about it, so, I thought that it would make sence to
>> > >find first what is his state at this problem.
>> > >
>> > >
>
> Content-Disposition: attachment; filename=file.c.diff2
>
> --- file.c~ 2004-10-02 12:29:33.223660850 +0400
> +++ file.c 2004-10-08 10:03:03.001561661 +0400
> @@ -1137,6 +1137,8 @@
>   return result;
>      }
>
> +    return generic_file_write(file, buf, count, ppos);
> +
>      if ( unlikely((ssize_t) count < 0 ))
>          return -EINVAL;
>

----- Original Message ----- 
From: "Chris Mason" <mason@suse.com>
To: "Hans Reiser" <reiser@namesys.com>
Cc: "Vladimir Saveliev" <vs@namesys.com>; "Oleg Drokin" 
<green@linuxhacker.ru>; "Jeremy Howard" <jhoward@fastmail.fm>; 
<reiserfs-dev@namesys.com>
Sent: Saturday, October 09, 2004 1:05 AM
Subject: Re: URGENT: Need fix for problem with copy_from_user inside 
atransaction


> On Fri, 2004-10-08 at 07:46 -0700, Hans Reiser wrote:
>> No, this is not the right answer.
>
>> >>>--- file.c~ 2004-10-02 12:29:33.223660850 +0400
>> >>>+++ file.c 2004-10-08 10:03:03.001561661 +0400
>> >>>@@ -1137,6 +1137,8 @@
>> >>> return result;
>> >>>     }
>> >>>
>> >>>+    return generic_file_write(file, buf, count, ppos);
>> >>>+
>> >>>     if ( unlikely((ssize_t) count < 0 ))
>> >>>         return -EINVAL;
>
> It's not right because ext3 has exactly the same bug.  The only real
> solution is to change the order in which things happen during
> file_write.
>
> Right now, we do this:
>
> prepare_write() allocates space, starts a transaction
> copy_from_user() can deadlock here because a transaction is running
> commit_write() end the transaction
>
> This is the same in generic_file_write and reiserfs_file_write, although
> reiserfs_file_write doesn't call reiserfs_prepare_write, it has the same
> basic structure in terms of when the transaction starts and ends.
>
> The solution is to move most of the work from reiserfs_prepare_write
> into reiserfs_commit_write.  I've made a number of different patches for
> this, all have had problems, but I'm working through it and will have a
> real tested fix.
>
> Jeremy the best thing you can do right now is to mount your filesystems
> with -o nolargeio=1, and use the temporary workarounds I sent you
> before.  The -o nolargeio=1 will reduce the amount of work we try to do
> with each pass in reiserfs_file_write (note that Vladimir's patch above
> will have very similar effects).
>
> -chris

