Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283836AbRLMNiT>; Thu, 13 Dec 2001 08:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283677AbRLMNiJ>; Thu, 13 Dec 2001 08:38:09 -0500
Received: from stine.vestdata.no ([195.204.68.10]:62354 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S282947AbRLMNiG>; Thu, 13 Dec 2001 08:38:06 -0500
Date: Thu, 13 Dec 2001 14:37:52 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Romano Giannetti <romano@dea.icai.upco.es>, linux-kernel@vger.kernel.org
Subject: Re: User-manageable sub-ids proposals
Message-ID: <20011213143752.A17124@vestdata.no>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <3C127551.90305@namesys.com> <20011211134213.G70201@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk> <3C1678ED.8090805@namesys.com> <20011212204333.A4017@pimlott.ne.mediaone.net> <3C1873A2.1060702@namesys.com> <20011213113616.B6547@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011213113616.B6547@pern.dea.icai.upco.es>; from romano@dea.icai.upco.es on Thu, Dec 13, 2001 at 11:36:16AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 11:36:16AM +0100, Romano Giannetti wrote:
> I am romano, uid 300.
> There is(/are) another(s) user, for example r-slave, uid 3001, no login
> shell, with home dir in ~romano/r-slave.

It would be so much nicer to be able to do this on-the-fly, rather than
having to create the user and it's home directory first.

However, I think one must first start with figguring out what
functionality we want:
1 do we want the "slave" to be able to read the users files
2 do we want the "slave" to be able to write the users files
3 do we want the "slave" to keep is own configuration files

And I think the answers are:
1. No. It would make it possible for broken/evil programs
   to steal your data.
2. Definitively not
3. No - it would cause different "slave" processes interact.
   It should rather use the users regular configuration files.

And we end up with a different solution:
olduid=getuid();
/* Allocate a uid with no privilegies */
slaveuid=setruid_slave(); 
set_acl("private-file", ACL_READ, slaveuid);
set_acl("private-log", ACL_APPEND, slaveuid);
seteuid(slaveuid);
exec("dangerous-program");


This should also be possible to implement with minimal impact. All you
need is a new systemcall to allocate a uid for the slave. This means you
need to reserve some uids for this purpose, but with 32bit uids......

A possible addon would be a systemcall to free the uid when it was not
in use anymore, so it can be reused safely. 

An alternative would be to not give the new uid access to the files, but
just open them before doing exec. This way it is safe to run multiple
slaves with the same uid at once, and it doesn't rely on ACLs! The
downside is that it needs cooperation from the dangerous-program, while
the above could work as long as the wrapper (e.g. a browser) took the
appropriate steps.


-- 
Ragnar Kjørstad
Big Storage
