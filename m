Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290926AbSBLKOu>; Tue, 12 Feb 2002 05:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290930AbSBLKOb>; Tue, 12 Feb 2002 05:14:31 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62222 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S290926AbSBLKOR>; Tue, 12 Feb 2002 05:14:17 -0500
Message-Id: <200202121012.g1CACht07809@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: System.map aughmentation: file names, email addresses
Date: Tue, 12 Feb 2002 12:12:44 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Keith Owens <kaos@ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I was thinking about better handling of oops reports.
There are two things I'm trying to do:

1. Add .c file names to function names in call trace.
Yes it's easily greppable and most hardcore haskers
already remember where those functions are, but _oops reporters_
are not. They need a way to figure what subsystem is failing and
where to send oops in addition to lkml. Maintainer don't read each
and every message on lkml.

2. When (1) is done, add email addresses of maintainers to .c
file names based on regexp match. Oops reporter will get CC list
prepared from oops.

I'm not hacked in ksymoops (yet?) but I have a pair of scripts which
generate aughmented System.map. Here they are for anybody curious.
--
vda

email2pattern.map - list of victims to CC
=================
Alexander Viro <viro@math.psu.edu>:^fs/[A-Za-z0-9]*.c$
Neil Brown <neilb@cse.unsw.edu.au>:fs/nfsd/.*
Neil Brown <neilb@cse.unsw.edu.au>:drivers/md/(md)|(raid)|(linear).*
Tester <tester@host.org>:.*/mm/.*
Tester2 <tester2@host.org>:.*usb.*
Tester3 <tester3@host.org>:^fs/.*
Tester4 <tester4@host.org>:.*ext2.*

gen_func2file
=============
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

gen_System.map.annot - yes, my first Python... it probably sucks
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
# Build email:pattern list
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
	print l+'\t'+file,
	for p in people:
	    t=string.split(p,':')
	    email=t[0]
	    pattern=t[1]
            expr=re.compile(pattern)
	    if expr.match(file):
		print '\t'+email,
	print
    else:
	print l
    l=f.readline()
