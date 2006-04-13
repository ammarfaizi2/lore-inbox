Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWDMNml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWDMNml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 09:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWDMNml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 09:42:41 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:54676 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964929AbWDMNmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 09:42:40 -0400
Date: Thu, 13 Apr 2006 15:42:39 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@openvz.org>
Cc: Sam Vilain <sam@vilain.net>, devel@openvz.org,
       Kir Kolyshkin <kir@sacred.ru>, linux-kernel@vger.kernel.org
Subject: Re: [Devel] Re: [RFC] Virtualization steps
Message-ID: <20060413134239.GA6663@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@openvz.org>,
	Sam Vilain <sam@vilain.net>, devel@openvz.org,
	Kir Kolyshkin <kir@sacred.ru>, linux-kernel@vger.kernel.org
References: <1143583179.6325.10.camel@localhost.localdomain> <4429B789.4030209@sacred.ru> <1143588501.6325.75.camel@localhost.localdomain> <442A4FAA.4010505@openvz.org> <20060329134524.GA14522@MAIL.13thfloor.at> <442A9E1E.4030707@sw.ru> <1143668273.9969.19.camel@localhost.localdomain> <443CBA48.7020301@sw.ru> <20060413010506.GA16864@MAIL.13thfloor.at> <443DF523.3060906@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443DF523.3060906@openvz.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 10:52:19AM +0400, Kirill Korotaev wrote:
> Herbert,
> 
> Thanks a lot for the details, I will give it a try once again. Looks 
> like fairness in this scenario simply requires sched_hard settings.

hmm, not precisely, it's a cpu limit you described
and that is what this configuration does, for fair
scheduling you need to activate the indle skip and
configure it in a similar way ...

> Herbert... I don't know why you've decided that my goal is to prove   
> that your scheduler is bad or not precise. My goal is simply to       
> investigate different approaches and make some measurements. 

fair enough ...

> I suppose you can benefit from such a volunteer, don't you think so?  

well, if the 'results' and 'methods' will be made
public, I can, until now all I got was something
along the lines:

 "Linux-VServer is not stable! WE (swsoft?) have
  a secret but essential test suite running two 
  weeks to confirm that OUR kernels ARE stable,
  and Linux-VServer will never pass those tests,
  but of course, we can't tell you what kind of
  tests or what results we got"

which doesn't help me anything and which, to be 
honest, does not sound very friendly either ...

> Anyway, thanks again and don't be cycled on the idea that OpenVZ are
> so cruel bad guys :)

but what about the Virtuozzo(tm) guys? :)
I'm really trying not to generalize here ...

best,
Herbert

> Thanks,
> Kirill
> 
> >well, your mistake seems to be that you probably haven't
> >tested this yet, because with the following (simple)
> >setups I seem to get what you consider impossible 
> >(of course, not as precise as your scheduler does it)
> >
> >
> >vcontext --create --xid 100 ./cpuhog -n 1 100 &
> >vcontext --create --xid 200 ./cpuhog -n 1 200 &
> >vcontext --create --xid 300 ./cpuhog -n 1 300 &
> >
> >vsched --xid 100 --fill-rate 1 --interval 6
> >vsched --xid 200 --fill-rate 2 --interval 6
> >vsched --xid 300 --fill-rate 3 --interval 6
> >
> >vattribute --xid 100 --flag sched_hard
> >vattribute --xid 200 --flag sched_hard
> >vattribute --xid 300 --flag sched_hard
> >
> >
> >  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND       
> >   39 root      25   0  1304  248  200 R   74  0.1   0:46.16 ./cpuhog -n 1 
> >   300  38 root      25   0  1308  252  200 H   53  0.1   0:34.06 ./cpuhog 
> >   -n 1 200  37 root      25   0  1308  252  200 H   28  0.1   0:19.53 
> >   ./cpuhog -n 1 100  46 root       0   0  1804  912  736 R    1  0.4   
> >   0:02.14 top -cid 20        
> >and here the other way round:
> >
> >vsched --xid 100 --fill-rate 3 --interval 6
> >vsched --xid 200 --fill-rate 2 --interval 6
> >vsched --xid 300 --fill-rate 1 --interval 6
> >
> >  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND       
> >   36 root      25   0  1304  248  200 R   75  0.1   0:58.41 ./cpuhog -n 1 
> >   100  37 root      25   0  1308  252  200 H   54  0.1   0:42.77 ./cpuhog 
> >   -n 1 200  38 root      25   0  1308  252  200 R   29  0.1   0:25.30 
> >   ./cpuhog -n 1 300  45 root       0   0  1804  912  736 R    1  0.4   
> >   0:02.26 top -cid 20        
> >
> >note that this was done on a virtual dual cpu
> >machine (QEMU 8.0) with 2.6.16-vs2.1.1-rc16 and
> >that there were roughly 25% idle time, which I'm
> >unable to explain atm ...
> >
> >feel free to jump on that fact, but I consider
> >it unimportant for now ...
> >
> >best,
> >Herbert
> >
> >
> >>Thanks,
> >>Kirill
> >
> >
> 
