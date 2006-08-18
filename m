Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWHRJPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWHRJPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWHRJPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:15:53 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:365 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751051AbWHRJPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:15:52 -0400
Date: Fri, 18 Aug 2006 11:11:39 +0200
From: Andreas Herrmann <aherrman@de.ibm.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Douglas Gilbert <dougg@torque.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux SCSI <linux-scsi@vger.kernel.org>, berthiaume_wayne@emc.com
Subject: Re: Random scsi disk disappearing
Message-ID: <20060818091139.GA6120@lion28.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.2006 00:33 Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Andreas Herrmann wrote:
> > Anyone interested in a script to conveniently interpret or change the
> > SCSI logging level? Such a script (scsi_logging_level) exists in the
> > s390-tools package (version 1.5.3).

> That would be very welcome.

See script below. To set SCSI_LOG_SCAN as discussed in this thread you
can use:

# scsi_logging_level -s --scan 7
New scsi logging level:
dev.scsi.logging_level = 448
SCSI_LOG_ERROR=0
SCSI_LOG_TIMEOUT=0
SCSI_LOG_SCAN=7
SCSI_LOG_MLQUEUE=0
SCSI_LOG_MLCOMPLETE=0
SCSI_LOG_LLQUEUE=0
SCSI_LOG_LLCOMPLETE=0
SCSI_LOG_HLQUEUE=0
SCSI_LOG_HLCOMPLETE=0
SCSI_LOG_IOCTL=0

> > If others show interest for this script, maybe a better place can be
> > found than s390-tools (because it is not really s390-specific).

> It could be put into linux/Documentation/scsi/. People who are 
> confronted with a debugging problem probably look into Documentation/. 
> Also, scripts which demonstrate usage of certain kernel interfaces do 
> count as valuable documentation.

I am not sure whehter this script should be added to
Documentation/scsi. I think it would be better to just document the
SCSI logging feature at all in Documentation/scsi and put the script
somewhere else.

Maybe Douglas Gilbert has a suggestion where such a script will best
fit in? He knows best which packages with scripts and utilities for
storage and SCSI are available.


Regards,

Andreas

--
#! /bin/bash
###############################################################################
# Conveniently create and set scsi logging level, show SCSI_LOG fields in human
# readable form.
#
# Copyright (C) IBM Corp. 2006
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.
###############################################################################


SCRIPTNAME="scsi_logging_level"

declare -i LOG_ERROR=0
declare -i LOG_TIMEOUT=0
declare -i LOG_SCAN=0
declare -i LOG_MLQUEUE=0
declare -i LOG_MLCOMPLETE=0
declare -i LOG_LLQUEUE=0
declare -i LOG_LLCOMPLETE=0
declare -i LOG_HLQUEUE=0
declare -i LOG_HLCOMPLETE=0
declare -i LOG_IOCTL=0

declare -i LEVEL=0

_ERROR_SHIFT=0
_TIMEOUT_SHIFT=3
_SCAN_SHIFT=6
_MLQUEUE_SHIFT=9
_MLCOMPLETE_SHIFT=12
_LLQUEUE_SHIFT=15
_LLCOMPLETE_SHIFT=18
_HLQUEUE_SHIFT=21
_HLCOMPLETE_SHIFT=24
_IOCTL_SHIFT=27

SET=0
GET=0
CREATE=0

OPTS=`getopt -o hvcgsa:E:T:S:I:M:L:H: --long \
help,version,create,get,set,all:,error:,timeout:,scan:,ioctl:,\
midlevel:,mlqueue:,mlcomplete:,lowlevel:,llqueue:,llcomplete:,\
highlevel:,hlqueue:,hlcomplete: -n \'$SCRIPTNAME\' -- "$@"`
eval set -- "$OPTS"

# print version info
printversion()
{
    cat <<EOF
$SCRIPTNAME (s390-tools) %S390_TOOLS_VERSION%
(C) Copyright IBM Corp. 2006
EOF
}

# print usage and help
printhelp()
{
    cat <<EOF
Usage: $SCRIPTNAME [OPTIONS]

Create, get or set scsi logging level.

Options:

        -h, --help       print this help
        -v, --version    print version information
        -s, --set        create and set logging level as specified on
                         command line
        -g, --get        get current logging level and display it
        -c, --create     create logging level as specified on command line
        -a, --all        specify value for all SCSI_LOG fields
        -E, --error      specify SCSI_LOG_ERROR
        -T, --timeout    specify SCSI_LOG_TIMEOUT
        -S, --scan       specify SCSI_LOG_SCAN
        -M, --midlevel   specify SCSI_LOG_MLQUEUE and SCSI_LOG_MLCOMPLETE
            --mlqueue    specify SCSI_LOG_MLQUEUE
            --mlcomplete specify SCSI_LOG_MLCOMPLETE
        -L, --lowlevel   specify SCSI_LOG_LLQUEUE and SCSI_LOG_LLCOMPLETE
            --llqueue    specify SCSI_LOG_LLQUEUE
            --llcomplete specify SCSI_LOG_LLCOMPLETE
        -H, --highlevel  specify SCSI_LOG_HLQUEUE and SCSI_LOG_HLCOMPLETE
            --hlqueue    specify SCSI_LOG_HLQUEUE
            --hlcomplete specify SCSI_LOG_HLCOMPLETE
        -I, --ioctl      specify SCSI_LOG_IOCTL

Exactly one of the options "-c", "-g" and "-s" has to be specified.
Valid values for SCSI_LOG fields are integers from 0 to 7.

Note: Several SCSI_LOG fields can be specified using several options.
When multiple options specify same SCSI_LOG field the most specific
option has precedence.

Example: "scsi_logging_level --hlqueue 3 --hlcomplete 2 --all 1 -s" sets
SCSI_LOG_HLQUEUE=3, SCSI_LOG_HLCOMPLETE=2 and assigns all other SCSI_LOG
fields the value 1.
EOF
}

check_level()
{
    if [ `echo -n $1 | tr --complement [:digit:] 'a' | grep -s 'a'` ]
    then
	invalid_cmdline "log level '$1' out of range [0, 7]"
    fi
	
    if [ $1 -lt 0 -o $1 -gt 7 ]
    then
	invalid_cmdline "log level '$1' out of range [0, 7]"
    fi
}

# check cmd line arguments
check_cmdline()
{
    while true ; do
	case "$1" in
	    -a|--all)	_ALL=$2; check_level $2
			shift 2;;
	    -c|--create) CREATE=1;
			shift 1;;
	    -g|--get)	GET=1
			shift 1;;
	    -h|--help) printhelp
			exit 0;;
	    -s|--set)	SET=1
			shift 1;;
	    -v|--version) printversion
			exit 0;;
	    -E|--error)	_ERROR=$2; check_level $2
			shift 2;;
	    -T|--timeout) _TIMEOUT=$2; check_level $2
			shift 2;;
	    -S|--scan)	_SCAN=$2; check_level $2
			shift 2;;
	    -M|--midlevel) _ML=$2; check_level $2
			shift 2;;
	    --mlqueue)	_MLQUEUE=$2; check_level $2
			shift 2;;
	    --mlcomplete) _MLCOMPLETE=$2; check_level $2
			shift 2;;
	    -L|--lowlevel) _LL=$2; check_level $2
			shift 2;;
	    --llqueue)	_LLQUEUE=$2; check_level $2
			shift 2;;
	    --llcomplete) _LLCOMPLETE=$2; check_level $2
			shift 2;;
	    -H|--highlevel) _HL=$2; check_level $2
			shift 2;;
	    --hlqueue)	_HLQUEUE=$2; check_level $2
			shift 2;;
	    --hlcomplete) _HLCOMPLETE=$2; check_level $2
			shift 2;;
	    -I|--ioctl) _IOCTL=$2; check_level $2
			shift 2;;
	    --) shift; break;;
	    *) echo "Internal error!" ; exit 1;;
	esac
    done

    if [ -n "$*" ]
    then
	invalid_cmdline invalid parameter $*
    fi

    if [ $GET = "1" -a $SET = "1" ]
    then
        invalid_cmdline options \'-c\', \'-g\' and \'-s\' are mutual exclusive
    elif [ $GET = "1" -a $CREATE = "1" ]
    then
        invalid_cmdline options \'-c\', \'-g\' and \'-s\' are mutual exclusive
    elif [ $SET = "1" -a $CREATE = "1" ]
    then
        invalid_cmdline options \'-c\', \'-g\' and \'-s\' are mutual exclusive
    fi
    
    LOG_ERROR=${_ERROR:-${_ALL:-0}}
    LOG_TIMEOUT=${_TIMEOUT:-${_ALL:-0}}
    LOG_SCAN=${_SCAN:-${_ALL:-0}}
    LOG_MLQUEUE=${_MLQUEUE:-${_ML:-${_ALL:-0}}}
    LOG_MLCOMPLETE=${_MLCOMPLETE:-${_ML:-${_ALL:-0}}}
    LOG_LLQUEUE=${_LLQUEUE:-${_LL:-${_ALL:-0}}}
    LOG_LLCOMPLETE=${_LLCOMPLETE:-${_LL:-${_ALL:-0}}}
    LOG_HLQUEUE=${_HLQUEUE:-${_HL:-${_ALL:-0}}}
    LOG_HLCOMPLETE=${_HLCOMPLETE:-${_HL:-${_ALL:-0}}}
    LOG_IOCTL=${_IOCTL:-${_ALL:-0}}
}

invalid_cmdline()
{
        echo "$SCRIPTNAME: $*"
	echo "$SCRIPTNAME: Try '$SCRIPTNAME --help' for more information."
	exit 1
}

get_logging_level()
{
    echo "Current scsi logging level:"
    LEVEL=`sysctl -n dev.scsi.logging_level`
    if [ $? != 0 ]
    then
 	echo "$SCRIPTNAME: could not read scsi logging level" \
             "(kernel probably without SCSI_LOGGING support)"
 	exit 1
    fi
}

show_logging_level()
{
    echo "dev.scsi.logging_level = $LEVEL"

    LOG_ERROR=$((($LEVEL>>$_ERROR_SHIFT) & 7))
    LOG_TIMEOUT=$((($LEVEL>>$_TIMEOUT_SHIFT) & 7))
    LOG_SCAN=$((($LEVEL>>$_SCAN_SHIFT) & 7))
    LOG_MLQUEUE=$((($LEVEL>>$_MLQUEUE_SHIFT) & 7))
    LOG_MLCOMPLETE=$((($LEVEL>>$_MLCOMPLETE_SHIFT) & 7))
    LOG_LLQUEUE=$((($LEVEL>>$_LLQUEUE_SHIFT) & 7))
    LOG_LLCOMPLETE=$((($LEVEL>>$_LLCOMPLETE_SHIFT) & 7))
    LOG_HLQUEUE=$((($LEVEL>>$_HLQUEUE_SHIFT) & 7))
    LOG_HLCOMPLETE=$((($LEVEL>>$_HLCOMPLETE_SHIFT) & 7))
    LOG_IOCTL=$((($LEVEL>>$_IOCTL_SHIFT) & 7))

    echo "SCSI_LOG_ERROR=$LOG_ERROR"
    echo "SCSI_LOG_TIMEOUT=$LOG_TIMEOUT"
    echo "SCSI_LOG_SCAN=$LOG_SCAN"
    echo "SCSI_LOG_MLQUEUE=$LOG_MLQUEUE"
    echo "SCSI_LOG_MLCOMPLETE=$LOG_MLCOMPLETE"
    echo "SCSI_LOG_LLQUEUE=$LOG_LLQUEUE"
    echo "SCSI_LOG_LLCOMPLETE=$LOG_LLCOMPLETE"
    echo "SCSI_LOG_HLQUEUE=$LOG_HLQUEUE"
    echo "SCSI_LOG_HLCOMPLETE=$LOG_HLCOMPLETE"
    echo "SCSI_LOG_IOCTL=$LOG_IOCTL"
}

set_logging_level()
{
    echo "New scsi logging level:"
    sysctl -q -w dev.scsi.logging_level=$LEVEL
    if [ $? != 0 ]
    then
 	echo "$SCRIPTNAME: could not write scsi logging level" \
 	     "(kernel probably without SCSI_LOGGING support)"
 	exit 1
    fi
}

create_logging_level()
{
    LEVEL=$((($LOG_ERROR & 7)<<$_ERROR_SHIFT))
    LEVEL=$(($LEVEL|(($LOG_TIMEOUT & 7)<<$_TIMEOUT_SHIFT)))
    LEVEL=$(($LEVEL|(($LOG_SCAN & 7)<<$_SCAN_SHIFT)))
    LEVEL=$(($LEVEL|(($LOG_MLQUEUE & 7)<<$_MLQUEUE_SHIFT)))
    LEVEL=$(($LEVEL|(($LOG_MLCOMPLETE & 7)<<$_MLCOMPLETE_SHIFT)))
    LEVEL=$(($LEVEL|(($LOG_LLQUEUE & 7)<<$_LLQUEUE_SHIFT)))
    LEVEL=$(($LEVEL|(($LOG_LLCOMPLETE & 7)<<$_LLCOMPLETE_SHIFT)))
    LEVEL=$(($LEVEL|(($LOG_HLQUEUE & 7)<<$_HLQUEUE_SHIFT)))
    LEVEL=$(($LEVEL|(($LOG_HLCOMPLETE & 7)<<$_HLCOMPLETE_SHIFT)))
    LEVEL=$(($LEVEL|(($LOG_IOCTL & 7)<<$_IOCTL_SHIFT)))
}

check_cmdline $*

if [ $SET = "1" ]
then
    create_logging_level
    set_logging_level
    show_logging_level
elif [ $GET = "1" ]
then
    get_logging_level
    show_logging_level
elif [ $CREATE = "1" ]
then
    create_logging_level
    show_logging_level
else
    invalid_cmdline missing option \'-g\', \'-s\' or \'-c\'
fi
