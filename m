Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291464AbSBNMFP>; Thu, 14 Feb 2002 07:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291519AbSBNMFG>; Thu, 14 Feb 2002 07:05:06 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:55570 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S291464AbSBNME4>; Thu, 14 Feb 2002 07:04:56 -0500
Message-Id: <200202141202.g1EC2Ft22198@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Russell King <rmk@arm.linux.org.uk>, Roberto Nibali <ratz@drugphish.ch>
Subject: Re: Improved ksymoops output
Date: Thu, 14 Feb 2002 14:02:16 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200202130805.g1D85st16817@Port.imtp.ilyichevsk.odessa.ua> <20020213101550.A11052@flint.arm.linux.org.uk>
In-Reply-To: <20020213101550.A11052@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 February 2002 08:15, Russell King wrote:
> > Trace; c0130e00 <__get_free_pages(mm/page_alloc.c)+10/1c>
> > Trace; c01459cf <__pollwait(fs/select.c:viro@math.psu.edu,tester3@host.org)+33/90>
>
> I don't call this format "better" nor "improved".
>
> It might be better to have something like this following at the end:
>
> File; __get_free_pages: mm/page_alloc.c
> File; __pollwait: fs/select.c
> File; do_select: fs/select.c
> File; process_timeout: kernel/sched.c
> File; restore_sigcontext: arch/i386/kernel/signal.c
> File; sock_poll: net/socket.c
> File; sys_gettimeofday: kernel/time.c
> File; sys_select: fs/select.c
> File; sys_setitimer: kernel/itimer.c
>
> Maintainer; fs/select.c <viro@math.psu.edu> <tester3@host.org>

After some thought I prefer file names on the "Trace;" lines.
"Maintainer;" is fine.

I have better script which does exactly this.
It does not use modified System.map.
It requires func2file.map and email2pattern.map.
Works as a filter for ksymoops. Sample output:

# ksymoops | add_file_email
Call Trace: [<c0130e00>] [<c01459cf>] [<c0113ee7>] [<c0113e38>] [<c021049f>]
   [<c0145d05>] [<c0146002>] [<c010644e>] [<c011b432>] [<c011b7e3>] [<c01071ff>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0130e00 <__get_free_pages+10/1c>        mm/page_alloc.c
Trace; c01459cf <__pollwait+33/90>      fs/select.c
Trace; c0113ee7 <schedule_timeout+4f/98>        kernel/sched.c
Trace; c0113e38 <process_timeout+0/60>  kernel/sched.c
Trace; c021049f <sock_poll+1f/24>       net/socket.c
Trace; c0145d05 <do_select+209/214>     fs/select.c
Trace; c0146002 <sys_select+2d2/620>    fs/select.c
Trace; c010644e <restore_sigcontext+126/138>    arch/i386/kernel/signal.c
Trace; c011b432 <sys_setitimer+76/150>  kernel/itimer.c
Trace; c011b7e3 <sys_gettimeofday+1b/17c>       kernel/time.c
Trace; c01071ff <system_call+33/38>


1 warning issued.  Results may not be reliable.

Maintainer; fs/select.c:tester3@host.org,viro@math.psu.edu

Script is below
--
vda

add_file_email
==============
#!/usr/bin/python

import sys
import string
import re

#
# Build func->file dictionary
#
f=open('func2file.map', 'r')
func2file={}
l=f.readline()
while l <> '':
    l=l[:len(l)-1]
    t=string.split(l)
    func2file[t[0]]=t[1]
    l=f.readline()

#
# Read email:pattern list
#
f=open('email2pattern.map', 'r')
people=[]
l=f.readline()
while l <> '':
    l=l[:len(l)-1]
    people.append(l)
    l=f.readline()

#
# Read stdin, add file names and email addresses to Trace; lines
#
f=sys.stdin
l=f.readline()
maint={}
while l <> '':
    l=l[:len(l)-1]
    if l[:6]=='Trace;':
	#print '>'+l[:6]+'<',l[:6]=='Trace;'
	func=string.split(string.split(l,'<')[1],'+')[0]
	#print func
	if func2file.has_key(func):
	    file=func2file[func]
	    l=l+'\t'+file
	    for p in people:
		t=string.split(p,':')
		email=t[0]
		pattern=t[1]
		expr=re.compile(pattern)
		if expr.match(file):
		    if maint.has_key(file):
			maint[file][email]=''
		    else:
			maint[file]={email:''}
    print l
    l=f.readline()

#
# Print "Maintainer; file:email,email" lines
#
print
for m in maint.keys():
    print 'Maintainer;',
    l=m+':'
    for e in maint[m].keys():
	l=l+e+','
print l[:len(l)-1]
