Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291449AbSBMIH7>; Wed, 13 Feb 2002 03:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291450AbSBMIHl>; Wed, 13 Feb 2002 03:07:41 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:21255 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S291449AbSBMIH2>; Wed, 13 Feb 2002 03:07:28 -0500
Message-Id: <200202130805.g1D85st16817@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Improved ksymoops output
Date: Wed, 13 Feb 2002 10:05:55 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Keith Owens <kaos@ocs.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was thinking of streamlining oops reports path.
Currently, people are expected to:
1) Run ksymoops
2) Figure out of function names where problems are.
   If one wants to look up source code of those functions,
   he is bound to do (lots of) grepping in source tree.
3) Figure out whom to email oops report.
   People _expected to_ look into MAINTAINERS file.

See that "_expected to_"? People frequently forget about it
(or even don't know). They mail to lkml only or worse, to Linus.
If maintainer isn't reading each and every lkml email, he can miss
oops report.

Running ksymoops is unavoidable, but other two steps can be automated,
and IMHO they should be.

It turned out to be trivially possible to fool ksymoops in taking System.map
where function names are accompanied with source file names and email
addresses of people willing to receive oopses. Emails are added by matching
regexp with filename. Let me show you how it looks like:

X             S C02AE060     8  2006   2005          2008       (NOTLB)
Call Trace: [<c0130e00>] [<c01459cf>] [<c0113ee7>] [<c0113e38>] [<c021049f>]
   [<c0145d05>] [<c0146002>] [<c010644e>] [<c011b432>] [<c011b7e3>] [<c01071ff>]

Normal ksymoops
===============
Call Trace: [<c0130e00>] [<c01459cf>] [<c0113ee7>] [<c0113e38>] [<c021049f>]
   [<c0145d05>] [<c0146002>] [<c010644e>] [<c011b432>] [<c011b7e3>] [<c01071ff>]
Warning (Oops_read): Code line not seen, dumping what data is available
Trace; c0130e00 <__get_free_pages+10/1c>
Trace; c01459cf <__pollwait+33/90>
Trace; c0113ee7 <schedule_timeout+4f/98>
Trace; c0113e38 <process_timeout+0/60>
Trace; c021049f <sock_poll+1f/24>
Trace; c0145d05 <do_select+209/214>
Trace; c0146002 <sys_select+2d2/620>
Trace; c010644e <restore_sigcontext+126/138>
Trace; c011b432 <sys_setitimer+76/150>
Trace; c011b7e3 <sys_gettimeofday+1b/17c>
Trace; c01071ff <system_call+33/38>

Ksymoops with file names and optionally regexp matched email addrs
==================================================================
Warning (compare_maps): ksyms_base symbol ... not found in System.map.  Ignoring ksyms_base entry
...<<tons of similar warnings>>...
Call Trace: [<c0130e00>] [<c01459cf>] [<c0113ee7>] [<c0113e38>] [<c021049f>]
   [<c0145d05>] [<c0146002>] [<c010644e>] [<c011b432>] [<c011b7e3>] [<c01071ff>]
Warning (Oops_read): Code line not seen, dumping what data is available
Trace; c0130e00 <__get_free_pages(mm/page_alloc.c)+10/1c>
Trace; c01459cf <__pollwait(fs/select.c:viro@math.psu.edu,tester3@host.org)+33/90>
Trace; c0113ee7 <schedule_timeout(kernel/sched.c)+4f/98>
Trace; c0113e38 <process_timeout(kernel/sched.c)+0/60>
Trace; c021049f <sock_poll(net/socket.c)+1f/24>
Trace; c0145d05 <do_select(fs/select.c:viro@math.psu.edu,tester3@host.org)+209/214>
Trace; c0146002 <sys_select(fs/select.c:viro@math.psu.edu,tester3@host.org)+2d2/620>
Trace; c010644e <restore_sigcontext(arch/i386/kernel/signal.c)+126/138>
Trace; c011b432 <sys_setitimer(kernel/itimer.c)+76/150>
Trace; c011b7e3 <sys_gettimeofday(kernel/time.c)+1b/17c>
Trace; c01071ff <system_call+33/38>
1044 warnings issued.  Results may not be reliable.

If you are willing to take a look, here are the scripts.
Usage: save files to kernel dir, then do:
# gen_func2file.map
# gen_System.map.annot >System.map.annot
# ksymoops -m System.map.annot <oops

email2pattern.map
=================
viro@math.psu.edu:^fs/[A-Za-z0-9]*.c$
neilb@cse.unsw.edu.au:fs/nfsd/.*
neilb@cse.unsw.edu.au:drivers/md/(md)|(raid)|(linear).*
tester@host.org:.*/mm/.*
tester2@host.org:.*usb.*
tester3@host.org:^fs/.*
tester4@host.org:.*ext2.*

gen_func2file.map
=================
#!/bin/sh
# Meant to be run in top lever kernel source dir
# after kernel has been built
#
# Makes list of the form:
# symbol1 object_file_pathname1
# symbol2 object_file_pathname2
# symbol3 object_file_pathname3
LIST=`find -name '*.c' | xargs`
> func2file.map
for a in $LIST; do
    #nm: get symbols from .o
    #grep: discard non-text symbols
    #awk: remove './', add .o pathname
    #cut: remove address and symbol type letter
    l=$((${#a}-2))
    b=${a:0:$l}
    if test -e "$b.o"; then
        nm "$b.o" \
	| grep '\( T \)\|\( t \)' \
	| awk "BEGIN { N=\" ${a:2:9999}\" } { print \$0,N }" \
	| cut -b12- \
	>> func2file.map
    fi
done

gen_System.map.annot
====================
#!/usr/bin/python
import string
import re
#
# Build func->file dictionary
#
f=open('func2file.map', 'r')
func2file={}
l=f.readline()
while l <> '':
    l=l[0:len(l)-1]
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
    l=l[0:len(l)-1]
    people.append(l)
    l=f.readline()
#
# Read System.map, add file names and email addresses
#
f=open('System.map', 'r')
l=f.readline()
while l <> '':
    l=l[0:len(l)-1]
    t=string.split(l)
    if func2file.has_key(t[2]):
	file=func2file[t[2]]
	l=l+'('+file
	el=''
	for p in people:
	    t=string.split(p,':')
	    email=t[0]
	    pattern=t[1]
            expr=re.compile(pattern)
	    if expr.match(file):
		el=el+','+email
	if el <> '':
	    l=l+':'+el[1:]
	l=l+')'
    print l
    l=f.readline()
--
vda
