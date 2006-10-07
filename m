Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423122AbWJGDk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423122AbWJGDk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 23:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423123AbWJGDk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 23:40:28 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:31878 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1423122AbWJGDk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 23:40:26 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Date: Sat, 07 Oct 2006 13:40:21 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <338ei25ni8d6o1ra6pllitgssf2qo1k17a@4ax.com>
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
In-Reply-To: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2006 01:36:24 +0200, "Jesper Juhl" <jesper.juhl@gmail.com> wrote:

>Hi,
>
>I've been using the this very simple script for a while to do test
>builds of the kernel :
>
>
>#!/bin/bash
>
>for i in $(seq 1 100); do
>        nice make distclean
>        while true; do
>                nice make randconfig
>                grep -q "CONFIG_EXPERIMENTAL=y" .config
>                if [ $? -eq 1 ]; then
>                        break
>                fi
>        done
>        cp .config config.${i}
>        nice make -j3 > build.log.${i} 2>&1
>done
>
>
>Which has worked great in the past, but with recent kernels it has
>been a sure way to cause a complete lockup within 1 hour :-(

There's some no-nos Adrian Bunk pointed out back when I was doing this, 
here's what I used last year -- it recently ran a hundred compiles but 
I forgot or lost the script that interpreted results :(  

grant@sempro:~$ cat /usr/local/bin/zrandom-build
#!/bin/bash
#
# 2.6 kernel random .config compiler driver
#
# Copyright (C) 2005 Grant Coady gcoady.lk@gmail.com
#
# GPL v2 per linux/COPYING by reference
#
# Thanks to:
# comp.unix.shell people:
#  Chris F.A. Johnson <http://cfaj.freeshell.org> for CLI number test
#  Ed Morton <morton@lsupcaemnt.com> for 'awk' solution in resuming
#  for answers to query 2005-07-27 for improvements to this script.
#
# linux-kernel people:
#  Adrian Bunk  Don't bother with useless CONFIG_BROKEN= .config
#                                         CONFIG_STANDALONE=
#  Jesper Juhl  Feedback
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# What?
# ``````
# A script to build random kernel .configs to discover kbuild errors.
# The .config, compiler output and time are recorded into the destination
#  directory.  Run several in parallel with outputs to different directories.
#
# The .config and compiler result are linked by a three digit number at
#  start of filename.
#
# Files
# ``````
# 000-about     record settings for a particular run
# ???-config    the .config
# ???-result    build (compiler) output
# ???-time      time to build in seconds and mm:ss (curiosity)
#
# Post processing of results lists each error (or warning) and the first
#  .config file triggering the error/warning.  Another script.
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# globals
clean=""        # -c set "Y" to do 'make clean' prior to compiles
store="../"     # -d destination directory
jobnr=""        # -jn make job control
limit=100       # -n number of .config builds to make
build="Y"       # -t clear to not build .config for testing
patch=""        # set "Y" to skip retry CONFIG_BROKEN=y .configs
count=0         # build counter
retry=0         # retry counter for useless .config filter
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Setup the trial series, command line interface

function show_usage
{
        echo "random-build
        random .config compiler driver for 2.6 series kernel
        usage: random-build [-d destination_directory] [-n nnn] [-t] [-u]

        -c      do 'make clean' prior to each compile, default off
        -d dir  destination for results, default ../
        -jn     make job control, n = 0..9
        -n nnn  number of compile runs, default 100
        -t      testing config driver, no build .config

        cd into linux top-level directory, specify an output directory
        outside the kernel directory, example command:

                random-build -c -n 333 -d ../trial-2.6.13-rc3-mm2-1

        would make clean prior to each build and place the results of
        333 random .config to directory ../trial-2.6.13-rc3-mm2-1

        Useless .config generated are skipped, read script source to see
        current setting; CONFIG_BROKEN=y is definitely useless :)
        "
        exit 1
}

function check_config_limit # limit
{
        case $1 in
                *[!0-9]*) limit=0;;
                *       ) limit=$1;;
        esac
        if [ $limit -lt 1 -o $limit -gt 999 ]; then
                limit=100
        fi
}

function check_create_dest # destination
{
        local crap="n"
        if [ ! -d "$1" ]; then
                echo -e \
                "Non-existent destination $1 specified, create it? (y/N) \c"
                read crap
                echo
                if [ "$crap" == "y" -o "$crap" == "Y" ]; then
                        mkdir "$1"
                else
                        echo "bad dest"; show_usage
                fi
        fi
        store=$1
}

# parse command line
while [ $1 ]; do
        case $1 in
                -c )    clean="Y";;     # do 'make clean'
                -d )    check_create_dest $2; shift;;
                -j[0-9]) jobnr=$1;;
                -n )    check_config_limit $2; shift;;
                -t )    build="";;      # disable build
                 * )    echo "bad CLI"; show_usage;;
        esac
        shift
done
echo "
#==>>
#==>>   Grant's random kernel configs $(date)
#==>>    $0 from $PWD
#==>>     host: linux-$(uname -r) on $HOSTNAME
#==>>      store=$store
#==>>       limit=$limit
#==>>        clean=$clean
#==>>         build=$build
#==>>          job control=$jobnr
#==>>
"       2>&1 | tee "$store/000-about"
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Run the trial series
#
# check if destination contains results, if so assume restart test run and
#  thus overwrite the last partial result, remove leading zeroes so number
#  is seen as decimal, not octal!  Queried comp.unix.shell - 2005-07-27...

function perhaps_resume_trial
{
        count=$(ls $store/*-config 2>/dev/null \
                | awk -F/ '{f=$NF}END{print f+0}')

        if [ $count -gt 0 -a $count -lt 1000 ]; then
                if [ $count -gt 1 ]; then
                        echo -e "\n#==>> Resuming: $count\n"
                fi
                ((count--))
        else
                count=0
        fi
}

function check_config
{
        local x=$(egrep \
                'CONFIG_BROKEN= | CONFIG_STANDALONE= | CONFIG_DEBUG_INFO=' \
                .config > /dev/null)
        return $x
}

function create_random_config
{
        if [ -n "$patch" ]; then
                make randconfig > /dev/null
        else
                while true; do
                        make randconfig > /dev/null
                        check_config && break
                        echo -e "\tRetry ($((++retry))): skipped useless .config"
                done
        fi
        cp .config "$store/$trial-config"
}

function build_random_config
{
        if [ -n "$build" ]; then
                [ -n "$clean" ] && make clean
                make $jobnr 2> "$store/$trial-result"
        fi
}

stamp=$SECONDS
function write_timestamp_file
{
        local t=0 m=0 s=0
        t=$((SECONDS - stamp))
        m=$(printf "%2d"  $((t / 60)))
        s=$(printf "%02d" $((t % 60)))
        echo -e "$t\t$m:$s" > "$store/$trial-time"
        stamp=$SECONDS
}

perhaps_resume_trial
while [ $((++count)) -le $limit ]; do

        trial=$(printf %003d $count)
        echo "#==>> $0, run $count: make randconfig"
        create_random_config
        build_random_config
        write_timestamp_file
done

echo "skipped $retry useless .config :o)"

# end

