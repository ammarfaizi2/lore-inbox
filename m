Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312600AbSEVMKy>; Wed, 22 May 2002 08:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312601AbSEVMKy>; Wed, 22 May 2002 08:10:54 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:6347 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S312600AbSEVMKx>; Wed, 22 May 2002 08:10:53 -0400
Message-ID: <3CEB8A8E.6090401@antefacto.com>
Date: Wed, 22 May 2002 13:09:50 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Nick Kurshev <nickols_k@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: /dev/port BUG and possible workaround
In-Reply-To: <20020522124116.680f59b8.nickols_k@mail.ru> <3CEB4E43.5020203@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> Uz.ytkownik Nick Kurshev napisa?:
> 
> ...
> 
>> 800=inl(CFC)
>> 2. Wrong log with using of /dev/port:
> 
> ...
> 
>> But it seems that nobody uses this device. Then what is goal
>> of implementing of this device?
> 
> Basically the goal is that contrary to some silly /proc
> stuff which is "en vouge" nowadays you have the ability to
> controll port access by using normal user permission control
> semantics of unix file access permissions, by giving /dev/port
> a proper group and so on. This is legacy crap of course, since
> the above goal can be reached by using a apache-suexec alike wrapper
> as well... even with more fine grained resolution of access controll.

It also allows you to write a watchdog driver in shell :-)

#!/bin/sh
# Padraig@antefacto.com
# This supports both the Ibase MB700 and Advantech PCM9576

usage() {
     echo "Usage: `basename $0` [pat] [playdead]"
     exit 1
}

if [ $# != 1 ]; then usage; fi;
if [ $1 != "pat" ]; then
     if [ $1 != "playdead" ]; then
         usage
     fi
fi

HW_VERSION=`cat /var/run/HW_VERSION`

if [ "$HW_VERSION" == "IBASE MB700" ];
     ENABLE_PORT=`printf %d 0x443`
     DISABLE_PORT=`printf %d 0x441`

     if [ $1 == "pat" ]; then
         TIMEOUT='\x5' #20 seconds (0=30s, 1=28s, ..., F=0s)
         printf "$TIMEOUT" | dd bs=1 seek=$ENABLE_PORT of=/dev/port
     else
         #write any value to port to disable
         printf "\001" | dd bs=1 seek=$DISABLE_PORT of=/dev/port
     fi
elif [ "$HW_VERSION" == "Advantech PCM9576" ]; then
     DISENABLE_PORT=`printf %d 0x443`

     if [ $1 == "pat" ]; then
         TIMEOUT='\x14' #20 seconds (1=1s, 2=2s, ..., 3E=62s)
         printf "$TIMEOUT" | dd bs=1 seek=$DISENABLE_PORT of=/dev/port
     else
         #read from port to disable
         dd bs=1 count=1 skip=$DISENABLE_PORT if=/dev/port of=/dev/null
     fi
fi

