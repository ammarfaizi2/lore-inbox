Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136152AbRAHAYg>; Sun, 7 Jan 2001 19:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136156AbRAHAY0>; Sun, 7 Jan 2001 19:24:26 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:38923 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136152AbRAHAYQ>;
	Sun, 7 Jan 2001 19:24:16 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Matthias Juchem <juchem@uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new bug report script 
In-Reply-To: Your message of "Sun, 07 Jan 2001 06:43:14 -0800."
             <3A588082.BCE1F971@linux.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2001 11:24:02 +1100
Message-ID: <8673.978913442@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Jan 2001 06:43:14 -0800, 
David Ford <david@linux.com> wrote:
>Matthias Juchem wrote:
>> My script is intended for the one who likes to provide bug reports but is
>> too lazy to look up all the information or simply is not sure about what
>> to include.
>
>Why can't it be done in sh?

In the dim, distant past I did a shell script that reads Changes,
extracts the lines which identify software versions and verifies that
your installed products were up to date.  I sent it to Linus several
times and got no response so I dropped it.  It was last run against
2.1.107, this is a quick and dirty upgrade against 2.4.0.  A lot of the
entries are there for historical reasons but are probably worth keeping
for reference.

The tricky bit with shell is handling the different output when the
script is run as sh -x script.  Use this script as a starting point if
you like it, if not, fold spindle and mutilate it.

--- check_linux_requirements ---

#!/bin/bash
#
#	Read Documentation/Changes, extract the required software levels
#	and check that the current system is up to date.  Developed for
#	2.1.107.  Will not work on 2.0.x because the Documentation/Changes
#	on 2.0.x systems does not include commands, at least up to 2.0.34.
#
#	Takes one optional parameter, the path to Documentation/Changes,
#	default is /usr/src/linux/Documentation/Changes.
#
#	This would be a lot easier in perl but users are not required to
#	have perl to install Linux.  awk was a possibility but some versions
#	of awk have been known to break on readline which I needed.  So shell
#	it is.
#
#	Keith Owens <kaos@ocs.com.au>.  GPL.  Sun Jun 28 21:20:10 EST 1998
#
#	Updated for 2.4.0 Keith Owens <kaos@ocs.com.au>.  Mon Jan  8 10:39:07 EST 2001
#
PATH=$PATH:/sbin:/bin:/usr/sbin:/usr/bin	# may not have root's path

required() {
	state=0
	confirm=0

	# NOTE: This code expects to see a line containing
	# "Current Minimal Requirements" on its own, followed by '==='
	# fillowed by each requirement on its own line starting with 'o',
	# terminated by any line starting with at least '===='.

	# Requirement lines must start with "o ".
	# The command to get the version (if any) must be preceded by '#'.
	# The version number must appear just before '#' or as the last field
	# if there is no command.

	while read line
	do
		if [ $state -eq 0 -a "$line" = "Current Minimal Requirements" ]
		then
			state=1
		fi
		if [ $state -ge 1 ]
		then
			if  ( expr "$line" : "====" > /dev/null )
			then
				state=$[$state + 1]
				if [ $state -eq 3 ]
				then
					break	# end of requirements
				fi
			fi
			if  ( ! expr "$line" : "o" > /dev/null )
			then
				continue
			fi
			line=${line#"o "}
			set -- $line
			text=$1
			version1=
			command=
			shift
			while [ -n "$2" -a "$2" != "#" ]
			do
				text="$text $1"
				shift
			done
			version1="$1"
			shift
			if [ "$1" = "#" ]
			then
				shift
			fi
			if [ -n "$1" ]
			then
				# pppd checks for device or tty before printing version.
				# < /dev/null causes an error.
				if [ "$text" = "PPP" ]
				then
					command="$1 < /dev/ttyS0"
				else
					command="$1 < /dev/null"
				fi
			fi
			while [ -n "$2" ]
			do
				if [ "X$2" = "Xor" ]
				then
					command="$command ;"
				else
					command="$command $2"
				fi
				shift
			done
			eval "($command)" 2>&1 | \
				verify "$text" "$version1" "$command"
			if [ $? -ne 0 ]
			then
				confirm=$[$confirm + 1]
			fi
		fi
	done
	if [ $state -ne 3 ]
	then
		echo "No requirements detected, probably an old Documentation/Changes file"
		return 2
	fi
	if [ $confirm -ne 0 ]
	then
		echo "$confirm package(s) to be manually confirmed"
		return 1
	fi
	return 0
}

verify() {
	# Extract the version number from program output and verify it
	text="$1"
	textlc=`echo "$1" | tr '[A-Z]' '[a-z]'`
	version1="$2"
	version2=
	command="$3"
	echo "$text"
	echo -ne "\tRequired $version1"
	if [ -z "$command" ]
	then
		echo -e "\t*** No command, unable to verify ***"
		return 1
	fi

	# Amazing how many different ways there are for software to display
	# their version number.  Special cases galore.

	case "$textlc" in
	modutils)			type=1; field=3;;
	"gnu c")			type=1; field=1;;
	"binutils")			type=1; field=4;;
	"linux c library")		type=2;;
	"linux libc5 c library")	type=2;;
	"linux libc6 c library")	type=5;;
	"dynamic linker (ld.so)")	type=3;;
	"linux c++ library")		type=2;;
	"pcmcia-cs")			type=1; field=3;;
	"procps")			type=1; field=3;;
	"procinfo")			type=1; field=5;;
	"psmisc")			type=1; field=5;;
	"mount")			type=1; field=2;;
	"net-tools")			type=1; field=2;;
	"sh-utils")			type=1; field=4;;
	"autofs")			type=1; field=4;;
	"nfs")				type=1; field=-1;;	# last field on line
	"bash")				type=1; field=4;;
	"ncpfs")			type=1; field=3;;
	"ppp")				type=1; field=3;;
	"gnu make")			type=1; field=4;;
	"util-linux")			type=1; field=3;;
	"e2fsprogs")			type=1; field=2;;
	"isdn4k-utils")			type=1; field=-1;;	# last field on line??  Needs to be tested
	*)
		echo -e "\t*** Unknown software '$textlc', unable to verify ***"
		echo "	check_linux_requirements might need to be upgraded"
		return 1
		;;
	esac

	found_version=0
	command_not_found=0
	while read line
	do
		# If running under set -x, the first line is the command
		# preceded by "++ " which confuses some tests.  Ignore all
		# lines starting with "++ ".
		if [ `expr "$line" : "++ "` = 3 ]
		then
			continue
		fi
		# Treat "command not found" as warning, not error.  Not everybody
		# needs every package.
		if [ `expr "$line" : "${myname}:.*: command not found\$"` -ne 0 ]
		then
			command_not_found=1
			continue
		fi
		set -- $line	# tokenize
		case $type in
		1)
			# Version on the first line in a specific field,
			# possibly preceded by "some-text-".
			if [ "X$1" = "XUsage:" -o \
			     `expr "$line" : '.*installed suid root'` -ne 0 -o \
			     `expr "$line" : '.*invalid option'` -ne 0 ]
			then
				break	# some error message instead
			fi
			if [ $field -lt 0 ]
			then
				# field -n from end of line
				field=$[$# + $field + 1]
			fi
			eval "version2=\$$field"
			prefix=`expr "$version2" : '\([a-z]*-\)*'`
			if [ -n "$prefix" ]
			then
				version2=${version2#$prefix}	# strip prefix
			fi
			found_version=1
			;;
		2)
			# libxxx versions.  Take the last symbolic link,
			# extract the version number from the file it points to.
			# Special case for libc, if the link is for libc.so.6*,
			# treat the version as 6.xxx, otherwise it complains
			# that you are back level, 2.0.xx is less than 5.x.xx.
			if [ `expr "X$1" : 'Xl'` -eq 2 ]
			then
				while [ "X$2" != "X->" ]
				do
					shift
				done
				version2=`echo "$3" | tr -cd '[.0-9]' | \
					  sed -e 's/\.\.*/./g' |
					  sed -e 's/^\.//g' |
					  sed -e 's/\.$//g'`
				if [ `expr "$1" : '.*libc.so.6'` != '0' ]
				then
					version2="6.$version2"
				fi
			fi
			;;
		3)
			# Version on first line that starts with ldd, last
			# field on the line.
			# Two different ldd commands are issued so have to read
			# all input.  Different versions of ldd have different
			# number of tokens :(.
			# Exclude error lines from old versions of ldd complaining
			# about --version.
			if [ `expr "$line" : '.*illegal option'` -ne 0 -o \
			     `expr "$line" : '.*invalid option'` -ne 0 ]

			then
				continue	# some error message instead
			fi
			if [ `expr "$1" : 'ldd'` -ne 0 ]
			then
				while [ -n "$2" ]
				do
					shift
				done
				version2=$1
				found_version=1
			fi
			;;
		4)
			# Version on first line that starts with pppd, made
			# up of fields 3 and 6.
			if [ "X$1" = "Xpppd" ]
			then
				version2="$3.$6"
				found_version=1
			fi
			;;
		5)
			# glibc versions.  Take the last symbolic link,
			# extract the version number from the file it points to.
			if [ `expr "X$1" : 'Xl'` -eq 2 ]
			then
				while [ "X$2" != "X->" ]
				do
					shift
				done
				version2=`echo "$3" | tr -cd '[.0-9]' | \
					  sed -e 's/\.\.*/./g' |
					  sed -e 's/^\.//g' |
					  sed -e 's/\.$//g'`
			fi
			;;
		*) ;;
		esac
		if [ $found_version -eq 1 ]
		then
			break
		fi
	done
	if [ $type -eq 2 -a -n "$version2" ]
	then
		found_version=1		# take the *last* symlink
	fi
	if [ $found_version -ne 1 ]
	then
		if [ $command_not_found -eq 1 ]
		then
			echo -e "\tPackage probably not installed, ignored"
			return 0	# don't count as an error
		else
			echo -e "\t*** No version number found, cannot verify ***"
			return 1
		fi
	fi
	version2=`echo $version2 | sed -e 's:,$::'`
	echo -ne "\tActual $version2"
	if compare_version "$textlc" "$version1" "$version2" 
	then
		echo -e "\tOK"
		return 0
	else
		echo -e "\t*** Possibly back level ***"
		return 1
	fi
}

compare_version() {
	# Amazing how many different ways there are for software to create
	# their version number.  Special cases galore.  Best case, convert
	# special characters such as '.', '(', ')' etc. to spaces, insert a
	# space where the version goes from letter to number or vice versa,
	# tokenize, compare the tokens as numbers or strings, as required.
	# Very, very messy!

	split_version "$1" v1 "$2"
	split_version "$1" v2 "$3"

	if [ $v1_max -lt $v2_max ]
	then
		max=$v2_max
	else
		max=$v1_max
	fi

	n=1
	while [ $n -le $max ]
	do
		eval "v1_token=\$v1_$n"
		eval "v2_token=\$v2_$n"
		if [ `expr "$v1_token" : '[0-9][0-9]*$'` != "0" ]
		then
			v1_digit=1
		else
			v1_digit=0
		fi
		if [ `expr "$v2_token" : '[0-9][0-9]*$'` != "0" ]
		then
			v2_digit=1
		else
			v2_digit=0
		fi
		if [ $v1_digit -eq 1 -a $v2_digit -eq 1 ]
		then
			# Two numeric tokens, compare as numbers.  Nobody is
			# going to catch me thinking that 2.1.100 is less than
			# 2.1.99 :).
			if [ $v2_token -lt $v1_token ]
			then
				return 1	# possibly back level
			elif [ $v2_token -gt $v1_token ]
			then
				return 0	# forward level
			fi
		elif [ $v1_digit -eq 0 -a $v2_digit -eq 0 ]
		then
			# Two string tokens.  It only makes sense to compare
			# them if both are one character long.  Otherwise
			# assume mismatch if they are not equal.
			if [ `expr "$v1_token" : '.*'` = "1" -a \
			     `expr "$v2_token" : '.*'` = "1" ]
			then
				if [ `expr "X$v2_token" "<" "X$v1_token"` -eq 1 ]
				then
					return 1	# possibly back level
				elif [ `expr "X$v2_token" ">" "X$v1_token"` -eq 1 ]
				then
					return 0	# forward level
				fi
			elif [ "X$v2_token" != "X$v1_token" ]
			then
				return 1	# possibly back level
			fi
		else
			# Mixed numeric and string tokens, although the string
			# token can be null.  If the v1 token is null then
			# assume that v2 has a more recent patch level and
			# accept it, otherwise give up.
			if [ -z "$v1_token" ]
			then
				return 0	# assume v2 has a patch level
			else
				return 1	# possibly back level
			fi
		fi
		n=$[$n + 1]
	done
	
	return 0
}

split_version() {
	# Split a version number into tokens (see compare_version) and store
	# the tokens in $1_n.  $1_max is the number of tokens.

	textlc=$1
	prefix=$2
	set -- `echo "$3" |
		tr '[A-Z]' '[a-z]' | tr '[]:;.(),+=-[]' ' ' |
		sed -e 's/\([a-z]\)\([0-9]\)/\1 \2/g' |
		sed -e 's/\([0-9]\)\([a-z]\)/\1 \2/g'`;

	# Special case net-tools.  If there are exactly two tokens and the
	# second token is more than 2 digits, split it into two subtokens
	# after the second digit.  Otherwise 1.432 is greater than 1.45.
	# Will not work after net-tools 1.99, hopefully the version number
	# problem is fixed by then.

	if [ "X$textlc" = "Xnet-tools" \
	     -a -n "$2" -a -z "$3" -a \
	     `expr length "$2"` -gt 2 ]
	then
		st1=`expr "$2" : '\(..\)'`
		st2=`expr "$2" : '..\(.*\)'`
		set -- "$1" "$st1" "$st2"
	fi

	n=0
	while [ -n "$1" ]
	do
		n=$[$n + 1]
		eval "${prefix}_$n=$1"
		shift
	done
	eval "${prefix}_max=$n"
}

changes=${1:-/usr/src/linux/Documentation/Changes}
myname=$0

echo "Verifying your software environment against the levels required"
echo "in $changes."
echo "NOTE: There are so many different ways that software can display a"
echo "      version number and they change over time.  It is not guaranteed"
echo "      that this script always gets it right.  Please manually check"
echo "      anything that says \"Possibly back level\".  If this script is"
echo "      wrong, notify the author.   Otherwise it is time to upgrade."
echo

# Simple, no :)?
required < $changes
exit $?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
