Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSLZHgB>; Thu, 26 Dec 2002 02:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSLZHgB>; Thu, 26 Dec 2002 02:36:01 -0500
Received: from packet.digeo.com ([12.110.80.53]:14252 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262602AbSLZHgA>;
	Thu, 26 Dec 2002 02:36:00 -0500
Message-ID: <3E0AB348.7EC3D454@digeo.com>
Date: Wed, 25 Dec 2002 23:44:08 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
CC: vda@port.imtp.ilyichevsk.odessa.ua, conma@kolivas.net,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Poor performance with 2.5.52, load and process in D state
References: <20021226000308.31344.qmail@linuxmail.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Dec 2002 07:44:08.0665 (UTC) FILETIME=[92C9CC90:01C2ACB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> Hi Andrew/Rik/Con/all
> 
> Andrew, I promised you to run a few tests
> using osdb (www.osdb.org with 40M of data)against both
> 2.4.19 and 2.5.52 booting the kernel with the
> mem=XXM paramter.
> 
> I also played with the /proc/sys/vm/swappiness
> parameter, I've ran all the tests with the standard
> swappiness value (60), with 80 and 100.
> 
> 100 means the 2.4 behaviour, isn't it ?

Not really.  swappiness=100 is strict LRU, treating pagecache and
mapped-into-process-memory pages identically.  Smaller values will
make the kernel prefer to preserve mapped-into-process-memory.

> Looking at the results it seems that the "standard"
> value is too low, probably 80 is the best one.
> What do you think ?

I would agree with that.
 
> ...
> 
> 2.4.19  all     x               778.65 seconds  (0:12:58.65)
> 2.5.52  all     60              768.98 seconds  (0:12:48.98)
> 2.5.52  all     80              770.43 seconds  (0:12:50.43)
> 2.5.52  all     100             771.76 seconds  (0:12:51.76)

Only 1% difference.  On my 4xPIII with mem=128M, 2.4.20-pre2 took
1080.55 seconds and 2.5.52-mm3 took 991.03.  That's 9% faster, and
from the profile:

c010a858 system_call                                 192   4.3636
c011e518 current_kernel_time                         201   3.3500
c012cdbc __generic_file_aio_read                     214   0.4652
c012bba0 kallsyms_lookup                             219   0.8295
c012ccec file_read_actor                             230   1.1058
c0145abc fget                                        318   4.1842
c01d3ed4 radix_tree_lookup                           384   3.8400
c0144be0 vfs_read                                    409   1.3279
c01315f4 check_poison_obj                            695   7.8977
c012c964 do_generic_mapping_read                    1007   1.1988
c01d7ae0 __copy_user_intel                         34130 213.3125
c0108a58 poll_idle                                299231 3562.2738

it appears that this benefit came from the special usercopy code.
What sort of CPU are you using?
