Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSG1IrC>; Sun, 28 Jul 2002 04:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314885AbSG1IrC>; Sun, 28 Jul 2002 04:47:02 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:44027 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S314529AbSG1Iq6>; Sun, 28 Jul 2002 04:46:58 -0400
Subject: Re: [PATCH] automatic initcalls
From: Keith Adamson <keith.adamson@attbi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207272145050.6125-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0207272145050.6125-100000@home.transmeta.com>
Content-Type: multipart/mixed; boundary="=-SXcrz8kgGTe1I4OhKU75"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-3) 
Date: 28 Jul 2002 04:50:59 -0400
Message-Id: <1027846262.29344.183.camel@h00d0700074d1.ne.client2.attbi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SXcrz8kgGTe1I4OhKU75
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-07-28 at 00:47, Linus Torvalds wrote:
> 
> 
> On Sat, 27 Jul 2002, Jeff Garzik wrote:
> >
> > I've always preferred a system where one simply lists dependencies [as
> > you describe above], and some program actually does the hard work of
> > chasing down all the initcall dependency checking and ordering.
> >
> > Linus has traditionally poo-pooed this so I haven't put any work towards
> > it...
> 
> I don't hate the notion, but at the same time every time it comes up I
> feel that there are reasonably simple ways to just avoid the ordering
> problems.
> 
> Rusty had a script, but somebody complained about the speed of it. I
> haven't looked at it myself.
> 
> 		Linus

There is a relatively simple and fast recursive algorithm I've used
before to generating a sequence from a dependency list.
For initcall sequence it would be something like this (bash scripts
attached);

Dependency database: dependency_list_database
Main programs:       make_initcall_seqence.sh
Recursive routine:   generate_initcall.sh

Output sequence:     initcall_sequence

See attached files.

Normally I have error checking for bad dependencies (you can get into a
infinite recursive loop if for instance "foo1" needs "foo2" and also
"foo2" needs "foo1") ... but I didn't do it to keep the algorithm more
understandable. 

Keith

--=-SXcrz8kgGTe1I4OhKU75
Content-Disposition: attachment; filename=make_initcall_seqence.sh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-sh; name=make_initcall_seqence.sh; charset=UTF-8

#!/bin/bash
#
#   make_initcall_seqence.sh - generate initcall sequence, file
#                          "initcall_sequence", from an initcall
#                          dependency list database, file
#                          "dependency_list_database"
#
# A random list of initcalls (will sequence them acording to the
# dependency database
initcall_list=3D$(sed 's,:.*$,,' dependency_list_database)
#
# Initialize the initcall_sequence file
rm -f initcall_sequence
touch initcall_sequence
#
# build the initcall_sequence file
for name in $initcall_list
do
        generate_initcall.sh $name
done

--=-SXcrz8kgGTe1I4OhKU75
Content-Disposition: attachment; filename=generate_initcall.sh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-sh; name=generate_initcall.sh; charset=UTF-8

#!/bin/bash
#
#   generate_initcall.sh - Insert initcall into the "initcall_sequence"
#                          file in correct sequence
#
# First arg is the initcall
initcall=3D$1
#
# Get dependency initcall list for this initcall from the dependency
# database
dependency_initcall_list=3D$(
        grep '^'$initcall'[ :]' dependency_list_database | \
                sed 's,^.*:,,'
        )
#
#  function to find a missing initcall in initcall_sequence
function find_missing_initcall()
{
        need_initcall=3D""
        for name in $dependency_initcall_list
        do
                # test if initcall not done in initcall_sequence
                if [ "$(grep '^'$name'$' initcall_sequence)" =3D "" ]
                then
                        # return needed initcall
                        need_initcall=3D$name
                        break
                fi
        done
}
#
#  generate missing initcalls that this initcall needs done first
#
find_missing_initcall
while [ -n "$need_initcall" ]    # loop while adding missing initcalls
do
        generate_initcall.sh $need_initcall  # NOTE THE RECURSIVE CALL
        find_missing_initcall
done
#
#  Finally add this initcall to initcall_sequence (if missing)
if [ "$(grep '^'$initcall'$' initcall_sequence)" =3D "" ]
then
        echo $initcall >> initcall_sequence
fi

--=-SXcrz8kgGTe1I4OhKU75
Content-Disposition: attachment; filename=dependency_list_database
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dependency_list_database; charset=UTF-8

foo1 : foo2 foo3
foo2 : foo5
foo3 : foo2 foo4
foo4 :
foo5 : foo4=20

--=-SXcrz8kgGTe1I4OhKU75--

