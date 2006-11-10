Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946692AbWKJO5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946692AbWKJO5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946699AbWKJO5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:57:30 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:6547 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946692AbWKJO5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:57:30 -0500
Date: Fri, 10 Nov 2006 20:27:15 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Paul Menage" <menage@google.com>
Cc: dev@openvz.org, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       Paul Jackson <pj@sgi.com>, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061110145715.GA15306@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030042714.fa064218.pj@sgi.com> <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com> <20061030123652.d1574176.pj@sgi.com> <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com> <20061031115342.GB9588@in.ibm.com> <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com> <20061101172540.GA8904@in.ibm.com> <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com> <20061106124948.GA3027@in.ibm.com> <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 12:23:44PM -0800, Paul Menage wrote:
> > Secondly, regarding how separate grouping per-resource *maybe* usefull,
> > consider this scenario.
> >
> > A large university server has various users - students, professors,
> > system tasks etc. The resource planning for this server could be on these lines:
> >
> >         CPU :           Top cpuset
> >                         /       \
> >                 CPUSet1         CPUSet2
> >                    |              |
> >                 (Profs)         (Students)
> >
> >                 In addition (system tasks) are attached to topcpuset (so
> >                 that they can run anywhere) with a limit of 20%
> >
> >         Memory : Professors (50%), students (30%), system (20%)
> >
> >         Disk : Prof (50%), students (30%), system (20%)
> >
> >         Network : WWW browsing (20%), Network File System (60%), others (20%)
> >                                 / \
> >                         Prof (15%) students (5%)

Lets say that network resource controller supports only one level
hierarchy, and hence you can only split it as:

        Network : WWW browsing (20%), Network File System (60%), others (20%)

> > Browsers like firefox/lynx go into the WWW network class, while (k)nfsd go
> > into NFS network class.
> >
> > At the same time firefox/lynx will share an appropriate CPU/Memory class
> > depending on who launched it (prof/student).
> >
> > If we had the ability to write pids directly to these resource classes,
> > then admin can easily setup a script which receives exec notifications
> > and depending on who is launching the browser he can
> >
> >         # echo browser_pid > approp_resource_class
> >
> > With your proposal, he now would have to create a separate container for
> > every browser launched and associate it with approp network and other
> > resource class. This may lead to proliferation of such containers.
> 
> Or create one container per combination (so in this case four,
> prof/www, prof/other, student/www, student/other) - then processes can
> be moved between the containers to get the appropriate qos of each
> type.
> 
> So the setup would look something like:
> 
> top-level: prof vs student vs system, with new child nodes for cpu,
> memory and disk, and no  new node for network
> 
> second-level, within the prof and student classes: www vs other, with
> new child nodes for network, and no new child nodes for cpu.
> 
> In terms of the commands to set it up, it might look like (from the top-level)
> 
> echo network > inherit
> mkdir prof student system
> echo disk,cpu,memory > prof/inherit
> mkdir prof/www prof/other
> echo disk,cpu,memory > student/inherit
> mkdir student/www student/other

By these commands, we would forcibly split the WWW bandwidth of 20%
between prof/www and student/www, when it was actually not needed (as
per the new requirement above). This forced split may be fine for a renewable 
resource like network bandwidth, but would be inconvenient for something like 
RSS, disk quota etc.

(I thought of a scheme where you can avoid this forced split by
maintaining soft/hard links to resource nodes from the container nodes.
Essentially each resource can have its own hierarchy of resource nodes.
Each resource node provides allocation information like min/max shares.
Container nodes point to one or more such resource nodes, implemented
as soft/hard links. This will avoid the forced split I mentioned above.
But I suspect we will run into atomicity issues again when modifying the 
container hierarchy).

Essentially by restrictly ourselves to a single hierarchy, we loose the 
flexibility of "viewing" each resource usage differently (network by traffic, 
cpu by users etc).

Coming to reality, I believe most work load management tools would be
fine to live with this restriction. AFAIK containers can also use this
model without much loss of flexibility. But if you are considering long term
user-interface stability, then this is something I would definitely
think hard about.

-- 
Regards,
vatsa
