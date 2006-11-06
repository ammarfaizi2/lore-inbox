Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753603AbWKFUYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbWKFUYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbWKFUYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:24:00 -0500
Received: from smtp-out.google.com ([216.239.33.17]:57880 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1753603AbWKFUX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:23:59 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=YeJM5T3qgUKoWouahQ0S1f/sjCN1v6T7lE2gIwNP1XrMO06xxG8ZYTFThEFTzyhzr
	wrHK+kp7Uo5kNwch+pQfQ==
Message-ID: <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
Date: Mon, 6 Nov 2006 12:23:44 -0800
From: "Paul Menage" <menage@google.com>
To: vatsa@in.ibm.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: "Paul Jackson" <pj@sgi.com>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061106124948.GA3027@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030031531.8c671815.pj@sgi.com>
	 <20061030042714.fa064218.pj@sgi.com>
	 <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
	 <20061030123652.d1574176.pj@sgi.com>
	 <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
	 <20061031115342.GB9588@in.ibm.com>
	 <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	 <20061101172540.GA8904@in.ibm.com>
	 <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	 <20061106124948.GA3027@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> On Wed, Nov 01, 2006 at 03:37:12PM -0800, Paul Menage wrote:
> > I saw your example, but can you give a concrete example of a situation
> > when you might want to do that?
>
> Paul,
>         Firstly, after some more thought on this, we can use your current
> proposal, if it makes the implementation simpler.

It does, but I'm more in favour of getting the abstractions right the
first time if we can, rather than implementation simplicity.

>
> Secondly, regarding how separate grouping per-resource *maybe* usefull,
> consider this scenario.
>
> A large university server has various users - students, professors,
> system tasks etc. The resource planning for this server could be on these lines:
>
>         CPU :           Top cpuset
>                         /       \
>                 CPUSet1         CPUSet2
>                    |              |
>                 (Profs)         (Students)
>
>                 In addition (system tasks) are attached to topcpuset (so
>                 that they can run anywhere) with a limit of 20%
>
>         Memory : Professors (50%), students (30%), system (20%)
>
>         Disk : Prof (50%), students (30%), system (20%)
>
>         Network : WWW browsing (20%), Network File System (60%), others (20%)
>                                 / \
>                         Prof (15%) students (5%)
>
> Browsers like firefox/lynx go into the WWW network class, while (k)nfsd go
> into NFS network class.
>
> At the same time firefox/lynx will share an appropriate CPU/Memory class
> depending on who launched it (prof/student).
>
> If we had the ability to write pids directly to these resource classes,
> then admin can easily setup a script which receives exec notifications
> and depending on who is launching the browser he can
>
>         # echo browser_pid > approp_resource_class
>
> With your proposal, he now would have to create a separate container for
> every browser launched and associate it with approp network and other
> resource class. This may lead to proliferation of such containers.

Or create one container per combination (so in this case four,
prof/www, prof/other, student/www, student/other) - then processes can
be moved between the containers to get the appropriate qos of each
type.

So the setup would look something like:

top-level: prof vs student vs system, with new child nodes for cpu,
memory and disk, and no  new node for network

second-level, within the prof and student classes: www vs other, with
new child nodes for network, and no new child nodes for cpu.

In terms of the commands to set it up, it might look like (from the top-level)

echo network > inherit
mkdir prof student system
echo disk,cpu,memory > prof/inherit
mkdir prof/www prof/other
echo disk,cpu,memory > student/inherit
mkdir student/www student/other

> Also lets say that the administrator would like to give enhanced network
> access temporarily to a student's browser (since it is night and the user
> wants to do online gaming :)  OR give one of the students simulation
> apps enhanced CPU power,
>
> With ability to write pids directly to resource classes, its just a
> matter of :
>
>         # echo pid > new_cpu/network_class
>         (after some time)
>         # echo pid > old_cpu/network_class
>
> Without this ability, he will have to split the container into a
> separate one and then associate the container with the new resource
> classes.

In practice though, do you think the admin would really want to be
have to move individual processes around by hand? Sure, it's possible,
but wouldn't it make more sense to just give the entire student/www
class more network bandwidth? Or more generically, how often are
people going to be needing to move individual processes from one QoS
class to another, rather than changing the QoS for the existing class?

Paul
