Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSGIJGS>; Tue, 9 Jul 2002 05:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317342AbSGIJGR>; Tue, 9 Jul 2002 05:06:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56455 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317341AbSGIJGQ>;
	Tue, 9 Jul 2002 05:06:16 -0400
Message-ID: <3D2AA802.2020705@us.ibm.com>
Date: Tue, 09 Jul 2002 02:08:18 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dan carpenter <error27@email.com>
CC: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: lock_kernel check...
References: <20020709081059.17951.qmail@email.com>
Content-Type: multipart/mixed;
 boundary="------------010403020502050902030203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010403020502050902030203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

cc'ing LKML 'cause this is interesting...

dan carpenter wrote:
 > As you can see, the attached script is dead simple.  It prints an
 > error every time you call return while lock_kernel is held.  On
 > your computer you will want to comment out print_url() and
 > uncomment the regular print statement.

I am continually amazed at all the simple, useful, cool stuff that 
people come up with.  I like!

 > I tested it on linux-2.5.7 because then I could just put a link to
 > the offending lines and get your feedback.  I compiled fs/*/*.c

Time to run it on some more recent versions.  Don't worry about not 
giving links, filename:line# is just fine for most people.  I promise 
_I_ won't complain :)

time for the breakdown:
  > http://lxr.linux.no/source/fs/affs/namei.c?v=2.5.7#L349
error

 > http://lxr.linux.no/source/fs/hpfs/dir.c?v=2.5.7#L194
error

 > http://lxr.linux.no/source/fs/intermezzo/dir.c?v=2.5.7#L580
 > http://lxr.linux.no/source/fs/intermezzo/dir.c?v=2.5.7#L594
 > http://lxr.linux.no/source/fs/intermezzo/file.c?v=2.5.7#L303
 > http://lxr.linux.no/source/fs/intermezzo/vfs.c?v=2.5.7#L1952
 > http://lxr.linux.no/source/fs/intermezzo/vfs.c?v=2.5.7#L2053

Intermezzo is doing some subtle things here.  It needs to do some 
dentry lookups and doesn't want to deadlock with dcache_lock (I 
think).  It releases the BKL to do these, then reacquires it so that 
the caller function doesn't double-unlock.  These are weird, but 
correct.

 > http://lxr.linux.no/source/fs/jbd/journal.c?v=2.5.7#L270

Another subtle one.  This is a throwback to the earliest days of the 
BKL where kernel daemons did a lock_kernel() while they were 
executing, and an unlock_kernel() when they were ready to give up the 
CPU.  This is still the case for kjournald, but in a much more 
convoluted way.  Since kjournald is a thread, when it returns, the 
process is destroyed and the BKL is released implcitly during the exit 
sequence.  That is why you never see an unlock_kernel().

Here's the basic process (may god help us all):

kernel_thread(kjournald,...) // start the new kjournald thread
lock_kernel()
work: // do work

// go to sleep for some reason
schedule()
	unlock_kernel()
	sleeping...
	wake_up()
	lock_kernel()

if( more to do )
	goto work;
else
	exit()
	unlock_kernel().


 > The question is are any of these actual errors?  What other things
 > are possibly illegal to do while lock_kernel is held?

It isn't absoulutely a bad thing to return while you have a lock held. 
    It might be hard to understand, or even crazy, but not immediately 
wrong :)

// BKL protects both "a", and io port 0xF00D
bar()
{
	lock_kernel();
	return inb(0xF00D);
}

int a;
foo()
{
	a = bar();
	a--;
	unlock_kernel();
}


But, back to the subject at hand.  Yes, you've found some errors here 
because in almost all normal cases, you don't mean to return with a 
lock still held.   These were most likely caused by myself or others 
pushing the BKL into these functions from above and are bugs.

Would you like to do the patches to fix it, or do you want me to do 
them?  They shouldn't be hard to do.

What is smatch.pm? I can't find it anywhere.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------010403020502050902030203
Content-Type: text/plain;
 name="lock-check.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lock-check.pl"

#!/usr/bin/perl -w
use smatch;

sub print_url {
  if (get_filename() =~ /home\/carp0110\/progs\/kernel\/devel\/linux-2.5.7\/(.*)/){
    print 'http://lxr.linux.no/source/', $1, '?v=2.5.7#', get_lineno(), "\n";
  }
}

while ($data = get_data()){
  # if we see a lock_kernel then we set the state to "locked"
  if ($data =~ /call_expr\(\(addr_expr function_decl\(lock_kernel/){
    set_state("locked");
    next;
  }

  # if we see an unlock_kernel we set the state to "unlocked"
  if ($data =~ /call_expr\(\(addr_expr function_decl\(unlock_kernel/){
    set_state("unlocked");
    next;
  }

  # if we see a return statement and the kernel is 
  # locked then we print a mesg.
  if ($data =~ /^return_stmt/){
    if (get_state() =~ /^locked$/){
      #print "Not unlocked: ", get_filename(), " ", get_start_line(), " ", get_lineno(), "\n";
      print_url();
      next;
    }
  }
}


--------------010403020502050902030203--

