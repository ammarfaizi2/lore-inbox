Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbQKHVkb>; Wed, 8 Nov 2000 16:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129676AbQKHVkV>; Wed, 8 Nov 2000 16:40:21 -0500
Received: from vti01.vertis.nl ([145.66.4.26]:14343 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S129911AbQKHVkL>;
	Wed, 8 Nov 2000 16:40:11 -0500
Message-ID: <938F7F15145BD311AECE00508B7152DB034C3A27@vts007.vertis.nl>
From: Rolf Fokkens <FokkensR@vertis.nl>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: problem with shmat () and > 1GB memory in kernel 2.2.17
Date: Wed, 8 Nov 2000 22:38:47 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
> 
> Recently we installed extra memory in our Oracle-on-Linux database server,
> it now has 1.25 GB. I installed a 2.2.17 kernel with the 2GB option
> enabled. I rebooted the machine (a Compaq Proliant 5500 dual PII 450MHz)
> and noticed that one of the databases wasn't able to start. After
> installing a 2.2.17 kernel without the 2GB option averything worked fine.
> 
> As said, one of the databases didn't start, it was the one with SID
> "linux" (this may be relevant to Oracle insiders), the other six databases
> started OK. After some reboots it appeared that espcially this database
> wouldn't start. Not being able to look into the source I did an strace on
> the server process that got into trouble, the text was something like
> "Unable to attach shared memory, OS Error 22". The strace generated a log
> which showed this:
> 
> shmget(IPC_PRIVATE, 33554432, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 4872
> shmat(4872, 0x29400000, 0)              = -1 EINVAL (Invalid argument)
> 
> This confirmed the problem of not being able to attach the shared memory.
> I also did an strace on this process on the 2.2.17 kernel without the 2GB
> option enabled, and it showd:
> 
> shmget(IPC_PRIVATE, 33554432, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 2568
> shmat(2568, 0x29400000, 0)              = 0x29400000
> 
> The failing shmat isn't the first one, but the ones before all succeed,
> some lines from the strace log:
> 
> shmget(IPC_PRIVATE, 49152, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 4865
> shmat(4865, 0x20000000, 0)              = 0x20000000
> shmget(IPC_PRIVATE, 26214400, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 4866
> shmat(4866, 0x20400000, 0)              = 0x20400000
> shmget(IPC_PRIVATE, 23068672, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 4867
> shmat(4867, 0x22000000, 0)              = 0x22000000
> shmget(IPC_PRIVATE, 19922944, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 4868
> shmat(4868, 0x23800000, 0)              = 0x23800000
> shmget(IPC_PRIVATE, 17825792, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 4869
> shmat(4869, 0x24c00000, 0)              = 0x24c00000
> shmget(IPC_PRIVATE, 29360128, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 4870
> shmat(4870, 0x26000000, 0)              = 0x26000000
> shmget(IPC_PRIVATE, 22020096, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 4871
> shmat(4871, 0x27c00000, 0)              = 0x27c00000
> shmget(IPC_PRIVATE, 33554432, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 4872
> shmat(4872, 0x29400000, 0)              = -1 EINVAL (Invalid argument)
> 
> On the 1GB kernel things go like this:
> 
> shmget(IPC_PRIVATE, 49152, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 2561
> shmat(2561, 0x20000000, 0)              = 0x20000000
> shmget(IPC_PRIVATE, 26214400, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 2562
> shmat(2562, 0x20400000, 0)              = 0x20400000
> shmget(IPC_PRIVATE, 23068672, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 2563
> shmat(2563, 0x22000000, 0)              = 0x22000000
> shmget(IPC_PRIVATE, 19922944, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 2564
> shmat(2564, 0x23800000, 0)              = 0x23800000
> shmget(IPC_PRIVATE, 17825792, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 2565
> shmat(2565, 0x24c00000, 0)              = 0x24c00000
> shmget(IPC_PRIVATE, 29360128, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 2566
> shmat(2566, 0x26000000, 0)              = 0x26000000
> shmget(IPC_PRIVATE, 22020096, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 2567
> shmat(2567, 0x27c00000, 0)              = 0x27c00000
> shmget(IPC_PRIVATE, 33554432, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 2568
> shmat(2568, 0x29400000, 0)              = 0x29400000
> shmget(IPC_PRIVATE, 32505856, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 2569
> shmat(2569, 0x2b400000, 0)              = 0x2b400000
> shmget(3779348124, 13291520, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 2570
> shmat(2570, 0x2d400000, 0)              = 0x2d400000
> 
> The only thing I see is that shmaddr (shmat's second argument) climbs
> above 0x28000000. This is confirmed by another database that runs fine on
> the 2GB kernel:
> 
> shmget(IPC_PRIVATE, 49152, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 7303
> shmat(7303, 0x20000000, 0)              = 0x20000000
> shmget(IPC_PRIVATE, 20971520, IPC_CREAT|IPC_EXCL|0x1a0|0640) = 7304
> shmat(7304, 0x20400000, 0)              = 0x20400000
> shmget(2522853243, 0, 0)                = -1 ENOENT (No such file or
> directory)
> shmat(7305, 0x21800000, 0)              = 0x21800000
> shmat(7305, 0, 0)                       = 0x2ac4a000
> shmat(7305, 0x21800000, 0)              = 0x21800000
> shmat(7303, 0x20000000, 0)              = 0x20000000
> shmat(7304, 0x20400000, 0)              = 0x20400000
> 
> All shmaddr's are below 0x28000000 and everything is fine. This may be
> accidental, but it's all I see.
> 
> Because the machine is a production system I installed the 1GB 2.2.17
> kernel, but I saved the strace logs, so If any you want's then I can mail
> them.
> 
> Rolf
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
