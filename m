Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319065AbSIJHdx>; Tue, 10 Sep 2002 03:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319066AbSIJHdx>; Tue, 10 Sep 2002 03:33:53 -0400
Received: from tnt-2-45.pops.easynet.fr ([212.180.33.45]:49402 "HELO
	hubert.heliogroup.fr") by vger.kernel.org with SMTP
	id <S319065AbSIJHdw>; Tue, 10 Sep 2002 03:33:52 -0400
From: Hubert Tonneau <hubert.tonneau@pliant.cx>
To: linux-kernel@vger.kernel.org
Subject: A service based ressources sharing model proposal
Date: Tue, 10 Sep 2002 07:36:58 GMT
X-Mailer: Pliant 76
Message-Id: <20020910073352Z319065-685+45664@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the general picture:
. each process is assigned to a service (Ingo pointed out that service
  could be group)
. each service has a profile specifying how many CPU percent, memory, threads
  handle, etc is assigned to it
. each service is assigned a timeout for shrinking ressources usage

The key idea is that the service profile does not prevent any process within
a service to get more ressources that what's assigned to the service, but
in case of lack of ressources, the profile will be used to decide who must
release some ressources.

Let's assume that at a given point, the kernel lacks of handles. Then
for each service, it will compute total handles consumed minus assigned
in the service profile. For the service having the highest difference,
it will send a signal to all processes in the service specifying 'hey,
you must close some handles'. Now, if after the service shrinking timeout
has ellapsed, there is still no handle available, the kernel will start
killing the processes within the faulty service.

The special case of CPU: As I suggested to Ingo, this would mean switching
the scheduler from a flat model (one process is selected to run) to a two
levels model (one service is selected to run, then one process within the
selected service is selected to run)

With such a service notion, you can have several services running in
one powerfull computer, let's say one SQL server, file sharing, and many
HTTP servers running chrooted, and be granted that if one web site
is suddenly under high load, then it will be abble to get most of the
ressources, including most of the CPU time, but will not be abble to disturb
other services, since they will still receive their assigned percentage of
the CPU when they require it, and in case of complete ressources stavation,
the right process (the one which is the most outside of it's profile)
will be killed first.

My view of the problem is that historically in Unix, one service was
basically one process. This is no more true and that's why the service
(once again, Ingo said it could be group) notion has to be introduced.

