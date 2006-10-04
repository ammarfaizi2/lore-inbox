Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWJDE3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWJDE3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWJDE3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:29:08 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:8226 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932351AbWJDE3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:29:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eO2wC26SanpNNp2j+C/s0OLKkvbbX5c/tcKoChohJcdg1xnSy3A4o3XOr2U0mbAaVU0rRvf8Dm352vX/pRLHQQ/DWLX/mhzPFF2p5mJEc+ZVzw9eP1Mr0fZqFGLdOv/DDWxOf2iE4Xu5eoqv5To8l/aDMdtZlvRIFaC+KHYi7C0=
Message-ID: <8a6316160610032129red27121rfceb223e04dc88a@mail.gmail.com>
Date: Tue, 3 Oct 2006 21:29:03 -0700
From: "Nick Austin" <nick.austin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Lock recursion deadlock detected
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following in my dmesg:

$ uname -a
Linux frank 2.6.17-1.2174_FC5 #1 SMP Tue Aug 8 15:30:44 EDT 2006
x86_64 x86_64 x86_64 GNU/Linux

It should be noted that lockd failed on this server at the same time.

Many entries like the flowing occurred on my NFS clients at the same time:
do_vfs_lock: VFS is out of sync with lock manager!
do_vfs_lock: VFS is out of sync with lock manager!
lockd: server 192.168.100.17 not responding, timed out
lockd: server 192.168.100.17 not responding, timed out

I'm reporting this, just as the error message asks. :)

Thanks!

==========================================
[ BUG: lock recursion deadlock detected! |
------------------------------------------

lockd/2607 is trying to acquire this lock:
 [ffffffff88b063a0] {nlm_file_mutex}
.. held by:             lockd: 2607 [ffff8101385fc040, 115]
... acquired at:               nlm_traverse_files+0x20/0x109 [lockd]
... trying at:                 nlm_release_file+0x35/0x111 [lockd]
------------------------------
| showing all locks held by: |  (lockd/2607 [ffff8101385fc040, 115]):
------------------------------

#001:             [ffffffff88b063a0] {nlm_file_mutex}
... acquired at:               nlm_traverse_files+0x20/0x109 [lockd]


lockd/2607's [current] stackdump:


Call Trace: <ffffffff88af81ba>{:lockd:nlm_release_file+53}
       <ffffffff802a1df0>{report_deadlock+321}
<ffffffff88af81ba>{:lockd:nlm_release_file+53}
       <ffffffff802a1fac>{check_deadlock+415}
<ffffffff88af81ba>{:lockd:nlm_release_file+53}
       <ffffffff88af81ba>{:lockd:nlm_release_file+53}
<ffffffff802a2059>{debug_mutex_add_waiter+159}
       <ffffffff802692e2>{__mutex_lock_slowpath+353}
<ffffffff88af627f>{:lockd:lockd+0}
       <ffffffff88af81ba>{:lockd:nlm_release_file+53}
<ffffffff88af722c>{:lockd:nlmsvc_free_block+162}
       <ffffffff88af718a>{:lockd:nlmsvc_free_block+0}
<ffffffff80237961>{kref_put+117}
       <ffffffff88af680c>{:lockd:nlmsvc_traverse_blocks+212}
       <ffffffff88af803a>{:lockd:nlm_traverse_files+88}
<ffffffff88af8113>{:lockd:nlmsvc_free_host_resources+40}
       <ffffffff88af8137>{:lockd:nlmsvc_invalidate_all+11}
       <ffffffff88af6381>{:lockd:lockd+258} <ffffffff80263b9e>{child_rip+8}
       <ffffffff88af627f>{:lockd:lockd+0} <ffffffff88af627f>{:lockd:lockd+0}
       <ffffffff80263b96>{child_rip+0}

Showing all blocking locks in the system:
S            init:    1 [ffff81013acb47a0, 115] (not blocked on mutex)
S     migration/0:    2 [ffff81013acb4040,   0] (not blocked on mutex)
S     ksoftirqd/0:    3 [ffff81013acb67e0, 134] (not blocked on mutex)
S      watchdog/0:    4 [ffff81013acb6080,   0] (not blocked on mutex)
S     migration/1:    5 [ffff81013acb7820,   0] (not blocked on mutex)
S     ksoftirqd/1:    6 [ffff81013acb70c0, 134] (not blocked on mutex)
S      watchdog/1:    7 [ffff81013acc3860,   0] (not blocked on mutex)
S        events/0:    8 [ffff81013aecb7a0, 110] (not blocked on mutex)
S        events/1:    9 [ffff81013aecb040, 110] (not blocked on mutex)
S         khelper:   10 [ffff81013aecc7e0, 110] (not blocked on mutex)
S         kthread:   11 [ffff81013aecc080, 113] (not blocked on mutex)
S       kblockd/0:   15 [ffff81013acca7a0, 110] (not blocked on mutex)
S       kblockd/1:   16 [ffff81013acca040, 110] (not blocked on mutex)
S          kacpid:   17 [ffff81013acc97e0, 114] (not blocked on mutex)
S           khubd:  149 [ffff81013acc9080, 110] (not blocked on mutex)
S         kseriod:  151 [ffff81013a917080, 110] (not blocked on mutex)
S         pdflush:  214 [ffff81013a9177e0, 120] (not blocked on mutex)
S         pdflush:  215 [ffff81013a911040, 115] (not blocked on mutex)
S         kswapd0:  216 [ffff81013a86c7e0, 115] (not blocked on mutex)
S           aio/0:  217 [ffff81013a9117a0, 113] (not blocked on mutex)
S           aio/1:  218 [ffff81013a910100, 113] (not blocked on mutex)
S       kpsmoused:  372 [ffff810139eb4860, 111] (not blocked on mutex)
S           ata/0:  393 [ffff810139f02100, 110] (not blocked on mutex)
S           ata/1:  394 [ffff810139f057a0, 110] (not blocked on mutex)
S       scsi_eh_0:  400 [ffff810139eac860, 115] (not blocked on mutex)
S       scsi_eh_1:  401 [ffff810139ef9040, 115] (not blocked on mutex)
S       scsi_eh_2:  402 [ffff810139efb7e0, 115] (not blocked on mutex)
S       scsi_eh_3:  403 [ffff810139efb080, 115] (not blocked on mutex)
S       scsi_eh_4:  428 [ffff810139eae040, 112] (not blocked on mutex)
S       scsi_eh_5:  429 [ffff810139ea5080, 112] (not blocked on mutex)
S       scsi_eh_6:  442 [ffff810139eef7e0, 111] (not blocked on mutex)
S       scsi_eh_7:  443 [ffff810139eab0c0, 111] (not blocked on mutex)
S        kmirrord:  477 [ffff81013a9bb040, 116] (not blocked on mutex)
S       md1_raid1:  492 [ffff810139eb3820, 110] (not blocked on mutex)
S       md0_raid1:  496 [ffff810139eb4100, 110] (not blocked on mutex)
S       kjournald:  502 [ffff810139eaf080, 110] (not blocked on mutex)
S         kauditd:  541 [ffff810139ea1820, 111] (not blocked on mutex)
S           udevd:  567 [ffff810139eaf7e0, 113] (not blocked on mutex)
S        khpsbpkt: 1421 [ffff810138746860, 115] (not blocked on mutex)
S     knodemgrd_0: 1457 [ffff8101387560c0, 116] (not blocked on mutex)
S       md2_raid5: 1671 [ffff81013a8d67e0, 110] (not blocked on mutex)
S       kjournald: 1706 [ffff81013a9bc7e0, 110] (not blocked on mutex)
S       kjournald: 1708 [ffff81013a8d80c0, 110] (not blocked on mutex)
S       kjournald: 1710 [ffff8101385fc7a0, 110] (not blocked on mutex)
S        cpuspeed: 1852 [ffff810138756820, 115] (not blocked on mutex)
S        cpuspeed: 1853 [ffff810139eb30c0, 115] (not blocked on mutex)
S        dhclient: 2151 [ffff8101387cf860, 115] (not blocked on mutex)
S         syslogd: 2186 [ffff8101377db820, 116] (not blocked on mutex)
R           klogd: 2189 [ffff81012f318860, 116] (not blocked on mutex)
S      irqbalance: 2199 [ffff8101386467e0, 116] (not blocked on mutex)
S         portmap: 2215 [ffff81013a86c080, 116] (not blocked on mutex)
S       rpc.statd: 2234 [ffff81013affb0c0, 116] (not blocked on mutex)
S           mdadm: 2244 [ffff81013731c080, 115] (not blocked on mutex)
S      rpc.idmapd: 2269 [ffff810138627100, 115] (not blocked on mutex)
S     dbus-daemon: 2283 [ffff810132f277e0, 115] (not blocked on mutex)
S            hcid: 2292 [ffff810139eee040, 125] (not blocked on mutex)
S            sdpd: 2297 [ffff81012f7a90c0, 125] (not blocked on mutex)
S        krfcommd: 2316 [ffff810139ea57e0, 110] (not blocked on mutex)
S            hidd: 2348 [ffff81012f318100, 115] (not blocked on mutex)
S       automount: 2475 [ffff810138627860, 116] (not blocked on mutex)
S          smartd: 2489 [ffff810139eee7a0, 116] (not blocked on mutex)
S           acpid: 2498 [ffff81013a9bc080, 116] (not blocked on mutex)
S           hpiod: 2507 [ffff810139eac100, 125] (not blocked on mutex)
S          python: 2512 [ffff81012e22b820, 115] (not blocked on mutex)
S           cupsd: 2523 [ffff810139eef080, 115] (not blocked on mutex)
S            sshd: 2554 [ffff81012e1ef080, 116] (not blocked on mutex)
S            ntpd: 2566 [ffff810132f27080, 115] (not blocked on mutex)
S     rpc.rquotad: 2583 [ffff810139ef97a0, 125] (not blocked on mutex)
S           nfsd4: 2603 [ffff81013a87e040, 110] (not blocked on mutex)
S            nfsd: 2604 [ffff81012e5717e0, 116] (not blocked on mutex)
S            nfsd: 2605 [ffff81012e1447a0, 115] (not blocked on mutex)
S            nfsd: 2606 [ffff81012eece100, 115] (not blocked on mutex)
R           lockd: 2607 [ffff8101385fc040, 115] (not blocked on mutex)
S        rpciod/0: 2608 [ffff810138646080, 110] (not blocked on mutex)
S            nfsd: 2609 [ffff81013a910860, 115] (not blocked on mutex)
S            nfsd: 2610 [ffff810139ef60c0, 115] (not blocked on mutex)
S            nfsd: 2611 [ffff8101377db0c0, 115] (not blocked on mutex)
S            nfsd: 2612 [ffff810138746100, 115] (not blocked on mutex)
S            nfsd: 2613 [ffff810139ef6820, 115] (not blocked on mutex)
S        rpciod/1: 2614 [ffff81013a9bb7a0, 110] (not blocked on mutex)
S      rpc.mountd: 2617 [ffff810139e067a0, 116] (not blocked on mutex)
S        sendmail: 2645 [ffff810139f02860, 116] (not blocked on mutex)
S        sendmail: 2653 [ffff81012d4ad860, 116] (not blocked on mutex)
S             gpm: 2663 [ffff81012db7f0c0, 115] (not blocked on mutex)
S           crond: 2672 [ffff81013731c7e0, 116] (not blocked on mutex)
S             tor: 2683 [ffff810139ea10c0, 115] (not blocked on mutex)
S             xfs: 2719 [ffff81012f7a9820, 116] (not blocked on mutex)
S       bacula-fd: 2732 [ffff81012cef97a0, 116] (not blocked on mutex)
S       bacula-fd: 2739 [ffff81012e144040, 115] (not blocked on mutex)
S       bacula-fd:15332 [ffff81007ba32820, 115] (not blocked on mutex)
S             atd: 2750 [ffff81012c380820, 115] (not blocked on mutex)
S    avahi-daemon: 2766 [ffff81012c0e0080, 115] (not blocked on mutex)
S    avahi-daemon: 2767 [ffff810139eab820, 125] (not blocked on mutex)
S cups-config-dae: 2776 [ffff810139eae7a0, 125] (not blocked on mutex)
S            hald: 2786 [ffff81012eece860, 116] (not blocked on mutex)
S     hald-runner: 2787 [ffff81012c390860, 116] (not blocked on mutex)
S hald-addon-acpi: 2793 [ffff81012c3800c0, 125] (not blocked on mutex)
S hald-addon-keyb: 2800 [ffff81012c72c080, 115] (not blocked on mutex)
S hald-addon-stor: 2821 [ffff81012cba4860, 116] (not blocked on mutex)
S           login: 2839 [ffff81013a8d6080, 117] (not blocked on mutex)
S        mingetty: 2840 [ffff81012b94d0c0, 122] (not blocked on mutex)
S        mingetty: 2841 [ffff81012c3d6040, 122] (not blocked on mutex)
S        mingetty: 2842 [ffff81012c9c47e0, 116] (not blocked on mutex)
S           login: 2847 [ffff81012c3d67a0, 117] (not blocked on mutex)
S        mingetty: 2850 [ffff81013a8d8820, 116] (not blocked on mutex)
S            bash: 2901 [ffff81012cba4100, 115] (not blocked on mutex)
S       ssh-agent: 2959 [ffff81012cf98100, 116] (not blocked on mutex)
S       gpg-agent: 2981 [ffff81012c9960c0, 115] (not blocked on mutex)
S       fetchmail: 3073 [ffff810139f05040, 115] (not blocked on mutex)
S          startx: 3074 [ffff81012bdc6040, 125] (not blocked on mutex)
S           xinit: 3090 [ffff81012cf98860, 117] (not blocked on mutex)
S               X: 3091 [ffff81012b57e040, 115] (not blocked on mutex)
S              sh: 3104 [ffff81013328d820, 118] (not blocked on mutex)
S        startkde: 3107 [ffff81012cae27e0, 117] (not blocked on mutex)
S         kdeinit: 3159 [ffff81013affb820, 115] (not blocked on mutex)
S      dcopserver: 3162 [ffff810130e8e7a0, 115] (not blocked on mutex)
S       klauncher: 3164 [ffff81012b57e7a0, 115] (not blocked on mutex)
S            kded: 3166 [ffff81012c923080, 115] (not blocked on mutex)
S      gam_server: 3168 [ffff81012c9237e0, 115] (not blocked on mutex)
S        kwrapper: 3174 [ffff81012c390100, 115] (not blocked on mutex)
S       ksmserver: 3176 [ffff81012db7f820, 115] (not blocked on mutex)
S            kwin: 3177 [ffff81013a87e7a0, 115] (not blocked on mutex)
S        kdesktop: 3179 [ffff81012ca4c100, 115] (not blocked on mutex)
S          kicker: 3181 [ffff810139e06040, 116] (not blocked on mutex)
S        kio_file: 3182 [ffff8101387cf100, 115] (not blocked on mutex)
S            kxkb: 3185 [ffff81012e1ef7e0, 115] (not blocked on mutex)
S           artsd: 3191 [ffff81012d4ad100, 115] (not blocked on mutex)
S         kaccess: 3194 [ffff81012cb9b7a0, 115] (not blocked on mutex)
S            kmix: 3198 [ffff81012cae2080, 115] (not blocked on mutex)
S            kgpg: 3200 [ffff81012ca4c860, 115] (not blocked on mutex)
S      krandrtray: 3203 [ffff81012c99c820, 115] (not blocked on mutex)
S            xmms: 3204 [ffff81012c496860, 115] (not blocked on mutex)
S            xmms: 3207 [ffff81012e571080, 115] (not blocked on mutex)
S            xmms: 3408 [ffff810120522820, 115] (not blocked on mutex)
S            xmms:18663 [ffff8101087da040, 115] (not blocked on mutex)
S       konqueror: 3208 [ffff81012c99c0c0, 115] (not blocked on mutex)
S         firefox: 3212 [ffff81012c996820, 123] (not blocked on mutex)
S         kalarmd: 3233 [ffff810120e5f0c0, 118] (not blocked on mutex)
S       konqueror: 3287 [ffff810120be37e0, 115] (not blocked on mutex)
S  run-mozilla.sh: 3291 [ffff8101205df040, 125] (not blocked on mutex)
S     firefox-bin: 3307 [ffff81012059e100, 115] (not blocked on mutex)
S     firefox-bin: 3409 [ffff810120f08040, 115] (not blocked on mutex)
S     firefox-bin: 3410 [ffff810120a55820, 115] (not blocked on mutex)
S        gconfd-2: 3412 [ffff81012c59b860, 115] (not blocked on mutex)
S         konsole: 3419 [ffff81012059e860, 115] (not blocked on mutex)
S            bash: 3420 [ffff810120f0e080, 115] (not blocked on mutex)
S          screen: 3523 [ffff81012bdc67a0, 115] (not blocked on mutex)
S            bash: 3524 [ffff8101205220c0, 115] (not blocked on mutex)
S            mutt: 3602 [ffff81011b1dc860, 116] (not blocked on mutex)
S            bash: 3606 [ffff81011762b7e0, 115] (not blocked on mutex)
S             ssh: 3685 [ffff81012e22b0c0, 116] (not blocked on mutex)
S            bash: 3686 [ffff81012c0e07e0, 115] (not blocked on mutex)
S             ssh: 3765 [ffff8101205df7a0, 115] (not blocked on mutex)
S            bash: 3770 [ffff810120be3080, 115] (not blocked on mutex)
S            bash: 4032 [ffff81010b68e7e0, 116] (not blocked on mutex)
S         gkrellm: 4110 [ffff81010b68e080, 115] (not blocked on mutex)
S            sshd: 4285 [ffff81010abad7e0, 116] (not blocked on mutex)
S            sshd: 4291 [ffff81012cb9b040, 115] (not blocked on mutex)
S            bash: 4292 [ffff81010aba4040, 115] (not blocked on mutex)
S       gpg-agent: 4321 [ffff8101047ed0c0, 115] (not blocked on mutex)
S       fetchmail: 4323 [ffff81010a1f30c0, 115] (not blocked on mutex)
S         kdeinit: 4453 [ffff810130e8e040, 117] (not blocked on mutex)
S      dcopserver: 4457 [ffff8101041b3040, 115] (not blocked on mutex)
S       klauncher: 4459 [ffff810103baa820, 115] (not blocked on mutex)
S            kded: 4462 [ffff81012c9c4080, 115] (not blocked on mutex)
S      gam_server: 4465 [ffff810103f6a7e0, 115] (not blocked on mutex)
S         knotify: 4471 [ffff810103b1e040, 115] (not blocked on mutex)
S          korgac: 4478 [ffff810103baa0c0, 115] (not blocked on mutex)
S            bash:19281 [ffff81008e219100, 116] (not blocked on mutex)
S          startx:19334 [ffff81008d2c07e0, 121] (not blocked on mutex)
S           xinit:19352 [ffff81008e21d0c0, 117] (not blocked on mutex)
S               X:19353 [ffff81010067c040, 115] (not blocked on mutex)
S        startkde:19358 [ffff81008cec1080, 116] (not blocked on mutex)
S     dbus-launch:19375 [ffff81008c831860, 116] (not blocked on mutex)
S     dbus-daemon:19376 [ffff81008c831100, 125] (not blocked on mutex)
S         kdeinit:19477 [ffff81008cff4100, 117] (not blocked on mutex)
S      dcopserver:19480 [ffff8100a57ec820, 115] (not blocked on mutex)
S       klauncher:19482 [ffff81006ed377a0, 115] (not blocked on mutex)
S            kded:19485 [ffff81008cf37100, 115] (not blocked on mutex)
S      gam_server:19487 [ffff81006cbbe7e0, 115] (not blocked on mutex)
S         kdeinit:19500 [ffff81008cff4860, 116] (not blocked on mutex)
S      dcopserver:19503 [ffff81006ed37040, 115] (not blocked on mutex)
S       klauncher:19505 [ffff81006c477820, 115] (not blocked on mutex)
S            kded:19507 [ffff81008e219860, 115] (not blocked on mutex)
S        kwrapper:19513 [ffff81008cf37860, 115] (not blocked on mutex)
S       ksmserver:19515 [ffff81008cec17e0, 115] (not blocked on mutex)
S            kwin:19516 [ffff81006c3cb0c0, 115] (not blocked on mutex)
S        kdesktop:19518 [ffff81010067c7a0, 115] (not blocked on mutex)
S          kicker:19520 [ffff8100be3a4100, 115] (not blocked on mutex)
S        kio_file:19521 [ffff81006cbbe080, 115] (not blocked on mutex)
S           artsd:19528 [ffff81011a12a100, 115] (not blocked on mutex)
S         kaccess:19530 [ffff81005c912040, 115] (not blocked on mutex)
S  pam-panel-icon:19532 [ffff8100916e67e0, 116] (not blocked on mutex)
S pam_timestamp_c:19533 [ffff810061162080, 115] (not blocked on mutex)
S         konsole:19534 [ffff8100a57ec0c0, 115] (not blocked on mutex)
S         konsole:19535 [ffff8100611627e0, 115] (not blocked on mutex)
S         konsole:19536 [ffff81005c9127a0, 115] (not blocked on mutex)
S            bash:19539 [ffff8100694dc7e0, 116] (not blocked on mutex)
S            bash:19560 [ffff8100a9ab5820, 125] (not blocked on mutex)
S            bash:19567 [ffff81008c8157a0, 125] (not blocked on mutex)
S         knotify:19771 [ffff810086de7820, 115] (not blocked on mutex)
S            bash:25869 [ffff8100a8adf820, 115] (not blocked on mutex)
S            sshd:26794 [ffff81003c6d1860, 117] (not blocked on mutex)
S            sshd:26801 [ffff81011697c820, 116] (not blocked on mutex)
S            bash:26802 [ffff810072b637e0, 116] (not blocked on mutex)
S         konsole:12220 [ffff810023665040, 115] (not blocked on mutex)
S            bash:12221 [ffff810008695100, 116] (not blocked on mutex)
S         knotify:12411 [ffff81000ac3e7e0, 115] (not blocked on mutex)
S             psi:13138 [ffff81003a4697e0, 115] (not blocked on mutex)
S bacula-tray-mon:15329 [ffff8100b9520100, 115] (not blocked on mutex)
S bacula-tray-mon:15331 [ffff8100209817a0, 115] (not blocked on mutex)
S          gataxx: 2143 [ffff810008f56080, 115] (not blocked on mutex)
?          gataxx: 2144 [ffff8100b0ebd0c0, 117] (not blocked on mutex)
S        gconfd-2: 2146 [ffff81007c080100, 115] (not blocked on mutex)
S            bash: 5985 [ffff81000cdf6080, 115] (not blocked on mutex)
S            mutt: 6067 [ffff810035881820, 116] (not blocked on mutex)
S          screen:15325 [ffff8100863c6100, 115] (not blocked on mutex)
S         azureus:15393 [ffff81012b94d820, 119] (not blocked on mutex)
S            java:15494 [ffff8100bec43860, 115] (not blocked on mutex)
S            java:15495 [ffff81010aba47a0, 116] (not blocked on mutex)
S            java:15496 [ffff81012c496100, 116] (not blocked on mutex)
S            java:15497 [ffff81011697c0c0, 115] (not blocked on mutex)
S            java:15498 [ffff810072b63080, 116] (not blocked on mutex)
S            java:15499 [ffff81006c3cb820, 116] (not blocked on mutex)
S            java:15500 [ffff81011b1dc100, 116] (not blocked on mutex)
S            java:15501 [ffff8100bf0970c0, 116] (not blocked on mutex)
S            java:15502 [ffff81012c72c7e0, 116] (not blocked on mutex)
S            java:15503 [ffff8100b0ebd820, 116] (not blocked on mutex)
S            java:15504 [ffff8100bde427a0, 116] (not blocked on mutex)
S            java:15505 [ffff81011a12a860, 115] (not blocked on mutex)
S            java:15506 [ffff81007ba320c0, 115] (not blocked on mutex)
S            java:15507 [ffff81003c6d1100, 115] (not blocked on mutex)
S            java:15509 [ffff810120a550c0, 116] (not blocked on mutex)
S            java:15510 [ffff8101040f0080, 115] (not blocked on mutex)
S            java:15511 [ffff81013328d0c0, 115] (not blocked on mutex)
S            java:15512 [ffff810008f567e0, 115] (not blocked on mutex)
S            java:15513 [ffff8101041b37a0, 116] (not blocked on mutex)
S            java:15514 [ffff810103b1e7a0, 115] (not blocked on mutex)
S            java:15515 [ffff8101034387a0, 115] (not blocked on mutex)
S            java:15516 [ffff81007c080860, 115] (not blocked on mutex)
S            java:15517 [ffff8100863c6860, 116] (not blocked on mutex)
S            java:15518 [ffff810020981040, 116] (not blocked on mutex)
S            java:15520 [ffff81008c815040, 115] (not blocked on mutex)
S            java:15521 [ffff81006c4770c0, 115] (not blocked on mutex)
S            java:15522 [ffff81008e21d820, 115] (not blocked on mutex)
S            java:15523 [ffff8100be3a4860, 115] (not blocked on mutex)
S            java:15524 [ffff810120f087a0, 116] (not blocked on mutex)
S            java:15525 [ffff810086de70c0, 115] (not blocked on mutex)
S            java:15527 [ffff810008695860, 115] (not blocked on mutex)
S            java:15528 [ffff81008d2c0080, 116] (not blocked on mutex)
S            java:15529 [ffff81012cef9040, 116] (not blocked on mutex)
S            java:15530 [ffff81000ac3e080, 116] (not blocked on mutex)
S            java:15532 [ffff81003ae42080, 115] (not blocked on mutex)
S            java:15533 [ffff81012c59b100, 116] (not blocked on mutex)
S            java:15534 [ffff8100236657a0, 116] (not blocked on mutex)
S            java:15535 [ffff8100a8adf0c0, 116] (not blocked on mutex)
S            java:15537 [ffff810103f6a080, 116] (not blocked on mutex)
S            java:15538 [ffff81010abad080, 116] (not blocked on mutex)
S            java:15541 [ffff810120e5f820, 116] (not blocked on mutex)
S            java:15542 [ffff81003a469080, 116] (not blocked on mutex)
S            java:15544 [ffff81012ff987a0, 118] (not blocked on mutex)
S            java:15546 [ffff8100916e6080, 115] (not blocked on mutex)
S            java:15548 [ffff81004cea17a0, 115] (not blocked on mutex)
S            java:15549 [ffff8100358810c0, 115] (not blocked on mutex)
S            java:15550 [ffff81000cdf67e0, 115] (not blocked on mutex)
S            java:15555 [ffff81010d3257e0, 116] (not blocked on mutex)
S            java:15556 [ffff81010d325080, 115] (not blocked on mutex)
S            java:15558 [ffff81010a1f3820, 116] (not blocked on mutex)
S            java:15560 [ffff81012ff98040, 115] (not blocked on mutex)
S            java:15561 [ffff810106d1c820, 115] (not blocked on mutex)
S            java:15562 [ffff810106d1c0c0, 115] (not blocked on mutex)
S            java:15565 [ffff810110acb7a0, 115] (not blocked on mutex)
S            java:15566 [ffff810110acb040, 115] (not blocked on mutex)
S            java:15577 [ffff81010ccca7e0, 115] (not blocked on mutex)
S            java:15579 [ffff81011762b080, 115] (not blocked on mutex)
S            java:15580 [ffff81010f900820, 119] (not blocked on mutex)
S            java:15591 [ffff81009cf66860, 115] (not blocked on mutex)
S            java:15597 [ffff81010d207820, 118] (not blocked on mutex)
S            java:15622 [ffff81011b391080, 118] (not blocked on mutex)
S            java:15635 [ffff8100a9ab50c0, 117] (not blocked on mutex)
S            java:15637 [ffff81010a9727e0, 116] (not blocked on mutex)
S            java:15642 [ffff8101101f2820, 115] (not blocked on mutex)
S            java:15643 [ffff810106c8c860, 115] (not blocked on mutex)
S            java:15645 [ffff810104a087a0, 116] (not blocked on mutex)
S            java:15646 [ffff8101101f20c0, 116] (not blocked on mutex)
S            java:15649 [ffff810104a08040, 116] (not blocked on mutex)
S            java:15655 [ffff8100496d9860, 115] (not blocked on mutex)
S            java:15656 [ffff810064e5f7e0, 115] (not blocked on mutex)
S            java:15659 [ffff810064e5f080, 117] (not blocked on mutex)
S            java:15660 [ffff81011213c7a0, 118] (not blocked on mutex)
S            java:15661 [ffff81011213c040, 115] (not blocked on mutex)
S            java:15665 [ffff81010a972080, 118] (not blocked on mutex)
S            java:15677 [ffff810100684860, 118] (not blocked on mutex)
S            java:15691 [ffff81010f9000c0, 118] (not blocked on mutex)
S            java:15704 [ffff810106c8c100, 118] (not blocked on mutex)
S            java:15721 [ffff810058b15080, 118] (not blocked on mutex)
S            java:15737 [ffff81002a5b67a0, 118] (not blocked on mutex)
S            java:15749 [ffff81010d2070c0, 118] (not blocked on mutex)
S            java:15761 [ffff81011b3917e0, 118] (not blocked on mutex)
S            java:15772 [ffff810007a65820, 118] (not blocked on mutex)
S            java:15783 [ffff8100430f2860, 118] (not blocked on mutex)
S            java:15796 [ffff8100753a27a0, 118] (not blocked on mutex)
S            java:15808 [ffff81005aa230c0, 118] (not blocked on mutex)
S            java:15827 [ffff81004c0e4820, 118] (not blocked on mutex)
S            java:15838 [ffff8100b9520860, 118] (not blocked on mutex)
S            java:15850 [ffff81004cb2a080, 118] (not blocked on mutex)
S            java:15860 [ffff810105b0b820, 118] (not blocked on mutex)
S            java:15870 [ffff810058b157e0, 118] (not blocked on mutex)
S            java:15882 [ffff8100496d9100, 118] (not blocked on mutex)
S            java:15895 [ffff810120f0e7e0, 118] (not blocked on mutex)
S            java:15907 [ffff810105b0b0c0, 118] (not blocked on mutex)
S            java:15917 [ffff8100430f2100, 118] (not blocked on mutex)
S            java:15932 [ffff8100adcc97e0, 118] (not blocked on mutex)
S            java:15943 [ffff81007f9c10c0, 118] (not blocked on mutex)
S            java:15953 [ffff81002a5b6040, 118] (not blocked on mutex)
S            java:15964 [ffff81005aa23820, 118] (not blocked on mutex)
S            java:15976 [ffff8100ac3ec040, 118] (not blocked on mutex)
S            java:15986 [ffff810007a650c0, 118] (not blocked on mutex)
S            java:15999 [ffff81009eb957e0, 118] (not blocked on mutex)
S            java:16010 [ffff81010ccca080, 118] (not blocked on mutex)
S            java:16021 [ffff8100753a2040, 118] (not blocked on mutex)
S            java:16032 [ffff8100ac3ec7a0, 118] (not blocked on mutex)
S            java:16045 [ffff81004dcdf820, 116] (not blocked on mutex)
S            java:16056 [ffff81009eb95080, 118] (not blocked on mutex)
S            java:16067 [ffff8100bb6557e0, 118] (not blocked on mutex)
S            java:16081 [ffff81011442f0c0, 118] (not blocked on mutex)
S            java:16091 [ffff810110b370c0, 118] (not blocked on mutex)
S            java:16106 [ffff8100568827a0, 118] (not blocked on mutex)
S            java:16124 [ffff8101121a3100, 118] (not blocked on mutex)
S            java:16136 [ffff8100480197e0, 118] (not blocked on mutex)
S            java:16147 [ffff810048019080, 118] (not blocked on mutex)
S            java:16158 [ffff81004dcdf0c0, 118] (not blocked on mutex)
S            java:16174 [ffff81011442f820, 118] (not blocked on mutex)
S            java:16188 [ffff8101351917a0, 118] (not blocked on mutex)
S            java:16203 [ffff8100adcc9080, 118] (not blocked on mutex)
S            java:16213 [ffff81007f9c1820, 118] (not blocked on mutex)
S            java:16229 [ffff81010b1ad100, 118] (not blocked on mutex)
S            java:16241 [ffff81010b1ad860, 118] (not blocked on mutex)
S            java:16253 [ffff81011097a040, 118] (not blocked on mutex)
S            java:16265 [ffff8100a00d7100, 118] (not blocked on mutex)
S            java:16279 [ffff810084fb17e0, 118] (not blocked on mutex)
S            java:16293 [ffff810042366860, 118] (not blocked on mutex)
S            java:16305 [ffff8100a60547a0, 118] (not blocked on mutex)
S            java:16321 [ffff810056882040, 118] (not blocked on mutex)
S            java:16333 [ffff8101047ed820, 118] (not blocked on mutex)
S            java:16342 [ffff810042366100, 118] (not blocked on mutex)
S            java:16354 [ffff810135191040, 118] (not blocked on mutex)
S            java:16368 [ffff8101121a3860, 118] (not blocked on mutex)
S            java:16385 [ffff81007ada10c0, 118] (not blocked on mutex)
S            java:16397 [ffff810084fb1080, 118] (not blocked on mutex)
S            java:16408 [ffff81007ada1820, 118] (not blocked on mutex)
S            java:16420 [ffff810110b37820, 118] (not blocked on mutex)
S            java:16431 [ffff8100bd838100, 118] (not blocked on mutex)
S            java:16442 [ffff810074846040, 118] (not blocked on mutex)
S            java:16457 [ffff81003fc86820, 118] (not blocked on mutex)
S            java:16469 [ffff810103cfc040, 117] (not blocked on mutex)
S            java:16481 [ffff8100a00d7860, 118] (not blocked on mutex)
S            java:16492 [ffff81010c0b8860, 118] (not blocked on mutex)
S            java:16504 [ffff810103cfd080, 118] (not blocked on mutex)
S            java:16517 [ffff81003fc860c0, 118] (not blocked on mutex)
S            java:16528 [ffff81010c0b8100, 118] (not blocked on mutex)
S            java:16539 [ffff81002a3510c0, 118] (not blocked on mutex)
S            java:16551 [ffff81002a351820, 118] (not blocked on mutex)
S            java:16566 [ffff810103cfd7e0, 118] (not blocked on mutex)
S            java:16576 [ffff810075716820, 118] (not blocked on mutex)
S            java:16589 [ffff81011228f0c0, 118] (not blocked on mutex)
S            java:16600 [ffff8100b08167e0, 118] (not blocked on mutex)
S            java:16612 [ffff810108dfd100, 118] (not blocked on mutex)
S            java:16628 [ffff8101321127e0, 118] (not blocked on mutex)
S            java:16643 [ffff810103cfc7a0, 118] (not blocked on mutex)
S            java:16660 [ffff8100748467a0, 118] (not blocked on mutex)
S            java:16670 [ffff8100757160c0, 118] (not blocked on mutex)
S            java:16681 [ffff810108dfd860, 118] (not blocked on mutex)
S            java:16702 [ffff810132112080, 118] (not blocked on mutex)
S            java:16723 [ffff8100b0816080, 118] (not blocked on mutex)
S            java:16734 [ffff810001ca6860, 118] (not blocked on mutex)
S            java:16745 [ffff810052cce100, 118] (not blocked on mutex)
S            java:16757 [ffff81000793a040, 118] (not blocked on mutex)
S            java:16770 [ffff8100098687a0, 118] (not blocked on mutex)
S            java:16780 [ffff810065290040, 118] (not blocked on mutex)
S            java:16790 [ffff81011097a7a0, 118] (not blocked on mutex)
S            java:16801 [ffff81000bddd7a0, 118] (not blocked on mutex)
S            java:16817 [ffff81000793a7a0, 118] (not blocked on mutex)
S            java:16829 [ffff810087aac7e0, 118] (not blocked on mutex)
S            java:16842 [ffff81000bddd040, 118] (not blocked on mutex)
S            java:16851 [ffff8100bd838860, 118] (not blocked on mutex)
S            java:16865 [ffff8100027fe080, 118] (not blocked on mutex)
S            java:16877 [ffff8100027fe7e0, 116] (not blocked on mutex)
S            java:16893 [ffff8100a6054040, 118] (not blocked on mutex)
S            java:16904 [ffff8101105d1040, 118] (not blocked on mutex)
S            java:16915 [ffff8100a6fb0080, 118] (not blocked on mutex)
S            java:16927 [ffff810001ca6100, 118] (not blocked on mutex)
S            java:16939 [ffff810101034860, 118] (not blocked on mutex)
S            java:16951 [ffff81004d96c0c0, 118] (not blocked on mutex)
S            java:16962 [ffff81004d96c820, 118] (not blocked on mutex)
S            java:16972 [ffff810101034100, 118] (not blocked on mutex)
S            java:16982 [ffff8101105d17a0, 118] (not blocked on mutex)
S            java:16992 [ffff810083e1d040, 118] (not blocked on mutex)
S            java:17005 [ffff81003afb0080, 118] (not blocked on mutex)
S            java:17016 [ffff810058c05860, 118] (not blocked on mutex)
S            java:17027 [ffff81011bbe27e0, 118] (not blocked on mutex)
S            java:17037 [ffff810058c05100, 118] (not blocked on mutex)
S            java:17053 [ffff810083e1d7a0, 118] (not blocked on mutex)
S            java:17062 [ffff8100420ab0c0, 118] (not blocked on mutex)
S            java:17074 [ffff81003afb07e0, 118] (not blocked on mutex)
S            java:17085 [ffff8100659eb860, 118] (not blocked on mutex)
S            java:17095 [ffff81011bbe2080, 118] (not blocked on mutex)
S            java:17108 [ffff8100659eb100, 118] (not blocked on mutex)
S            java:17135 [ffff81009baeb7a0, 118] (not blocked on mutex)
S            java:17200 [ffff810060285100, 118] (not blocked on mutex)
S            java:17223 [ffff81004e75b100, 118] (not blocked on mutex)
S            java:17236 [ffff81010d8e67e0, 118] (not blocked on mutex)
S            java:17284 [ffff8100bde42040, 118] (not blocked on mutex)
S            java:17294 [ffff81002c6a6040, 118] (not blocked on mutex)
S            java:17307 [ffff810139736860, 118] (not blocked on mutex)
S            java:17327 [ffff810060285860, 118] (not blocked on mutex)
S            java:17345 [ffff8100355c3860, 116] (not blocked on mutex)
S            java:17361 [ffff8101198b90c0, 118] (not blocked on mutex)
S            java:17374 [ffff8100420ab820, 118] (not blocked on mutex)
S            java:17404 [ffff810078d3e080, 118] (not blocked on mutex)
S            java:17429 [ffff8100b15687e0, 118] (not blocked on mutex)
S            java:17440 [ffff810103438040, 118] (not blocked on mutex)
S            java:17451 [ffff81002c6a67a0, 118] (not blocked on mutex)
S            java:17463 [ffff810080adf0c0, 118] (not blocked on mutex)
S            java:17483 [ffff81006b52d860, 118] (not blocked on mutex)
S            java:17498 [ffff81009cf66100, 118] (not blocked on mutex)
S            java:17510 [ffff8100b1568080, 118] (not blocked on mutex)
S            java:17521 [ffff810080adf820, 118] (not blocked on mutex)
S            java:17533 [ffff8100355c3100, 118] (not blocked on mutex)
S            java:17545 [ffff8100b8408860, 118] (not blocked on mutex)
S            java:17556 [ffff8100792187a0, 118] (not blocked on mutex)
S            java:17570 [ffff810079218040, 118] (not blocked on mutex)
S            java:17585 [ffff8100652907a0, 118] (not blocked on mutex)
S            java:17599 [ffff810100b097a0, 118] (not blocked on mutex)
S            java:17619 [ffff81011b124040, 118] (not blocked on mutex)
S            java:17629 [ffff81011b1247a0, 118] (not blocked on mutex)
S            java:17641 [ffff8100586fb0c0, 118] (not blocked on mutex)
S            java:17652 [ffff810116900100, 118] (not blocked on mutex)
S            java:17663 [ffff8101040f07e0, 118] (not blocked on mutex)
S            java:17676 [ffff8100bec43100, 118] (not blocked on mutex)
S            java:17686 [ffff81004e75b860, 118] (not blocked on mutex)
S            java:17697 [ffff810131a56860, 118] (not blocked on mutex)
S            java:17709 [ffff81011228f820, 118] (not blocked on mutex)
S            java:17725 [ffff81011f6f50c0, 118] (not blocked on mutex)
S            java:17740 [ffff81004cb2a7e0, 118] (not blocked on mutex)
S            java:17755 [ffff810101d51100, 118] (not blocked on mutex)
S            java:17771 [ffff810100b09040, 118] (not blocked on mutex)
S            java:17783 [ffff8101198b9820, 118] (not blocked on mutex)
S            java:17793 [ffff8100b8408100, 118] (not blocked on mutex)
S            java:17839 [ffff810107e7a040, 118] (not blocked on mutex)
S            java:17858 [ffff81010b78b100, 118] (not blocked on mutex)
S            java:17869 [ffff810116900860, 118] (not blocked on mutex)
S            java:17889 [ffff81010d9ee0c0, 118] (not blocked on mutex)
S            java:17900 [ffff810101d51860, 118] (not blocked on mutex)
S            java:17911 [ffff810134533080, 118] (not blocked on mutex)
S            java:17921 [ffff8100bb655080, 118] (not blocked on mutex)
S            java:17947 [ffff8100694dc080, 118] (not blocked on mutex)
S            java:17954 [ffff8101087da7a0, 115] (not blocked on mutex)
S            java:17967 [ffff81011a521100, 118] (not blocked on mutex)
S            java:17988 [ffff81011948f040, 118] (not blocked on mutex)
S            java:17993 [ffff8101187fd7e0, 115] (not blocked on mutex)
S            java:18002 [ffff81010f57a0c0, 118] (not blocked on mutex)
S            java:18013 [ffff8100586fb820, 118] (not blocked on mutex)
S            java:18102 [ffff810100b9b7e0, 118] (not blocked on mutex)
S            java:18114 [ffff810116281820, 118] (not blocked on mutex)
S            java:18124 [ffff8101162810c0, 118] (not blocked on mutex)
S            java:18139 [ffff81010b78b860, 118] (not blocked on mutex)
S            java:18152 [ffff81011a521860, 118] (not blocked on mutex)
S            java:18156 [ffff81011f6f5820, 116] (not blocked on mutex)
S            java:18172 [ffff810107e7a7a0, 118] (not blocked on mutex)
S            java:18193 [ffff81010f57a820, 118] (not blocked on mutex)
S            java:18210 [ffff810087aac080, 118] (not blocked on mutex)
S            java:18221 [ffff8101096f67e0, 118] (not blocked on mutex)
S            java:18232 [ffff810100b9b080, 118] (not blocked on mutex)
S            java:18249 [ffff810135f68100, 118] (not blocked on mutex)
S            java:18274 [ffff8100259be7e0, 118] (not blocked on mutex)
S            java:18288 [ffff8100bf097820, 118] (not blocked on mutex)
S            java:18310 [ffff81010d8e6080, 118] (not blocked on mutex)
S            java:18323 [ffff81006b52d100, 118] (not blocked on mutex)
S            java:18336 [ffff8101345337e0, 118] (not blocked on mutex)
S            java:18348 [ffff810109b46820, 118] (not blocked on mutex)
S            java:18366 [ffff81010eb95860, 118] (not blocked on mutex)
S            java:18404 [ffff810105b8f0c0, 118] (not blocked on mutex)
S            java:18422 [ffff8101104d9100, 118] (not blocked on mutex)
S            java:18441 [ffff8101359d60c0, 118] (not blocked on mutex)
S            java:18571 [ffff8101104d9860, 118] (not blocked on mutex)
S            java:18588 [ffff810134af5100, 118] (not blocked on mutex)
S            java:18597 [ffff8101359d6820, 116] (not blocked on mutex)
S            java:18604 [ffff81009baeb040, 118] (not blocked on mutex)
S            java:18622 [ffff810115a12100, 115] (not blocked on mutex)
S            java:18626 [ffff8101347e50c0, 118] (not blocked on mutex)
S            java:18639 [ffff810122f0f7a0, 118] (not blocked on mutex)
S            java:18649 [ffff810101e0e820, 118] (not blocked on mutex)
S            java:18653 [ffff810131a56100, 115] (not blocked on mutex)
S            java:18662 [ffff810109b460c0, 118] (not blocked on mutex)
S            java:18670 [ffff810134af5860, 115] (not blocked on mutex)
S            java:18674 [ffff810110085040, 115] (not blocked on mutex)
S   kdesktop_lock:15687 [ffff81004c0e40c0, 115] (not blocked on mutex)
T           laser:15688 [ffff810100684100, 134] (not blocked on mutex)
S       konqueror:17138 [ffff8100259be080, 115] (not blocked on mutex)
S        kio_file:17148 [ffff810078d3e7e0, 115] (not blocked on mutex)
S         kontact:17402 [ffff810139736100, 115] (not blocked on mutex)
S         kontact:17405 [ffff8100a6fb07e0, 118] (not blocked on mutex)
S         kontact:17406 [ffff81004cea1040, 118] (not blocked on mutex)
S         kontact:17407 [ffff810052cce860, 118] (not blocked on mutex)
S         kontact:17408 [ffff81003ae427e0, 119] (not blocked on mutex)
S  kwalletmanager:17412 [ffff810009868040, 115] (not blocked on mutex)
S            xmms:18209 [ffff81011948f7a0, 115] (not blocked on mutex)
S   kio_thumbnail:18414 [ffff810105b8f820, 120] (not blocked on mutex)
S              gs:18439 [ffff8101096f6080, 116] (not blocked on mutex)
S              gs:18440 [ffff810135f68860, 115] (not blocked on mutex)
S         firefox:18531 [ffff8101303a9860, 118] (not blocked on mutex)
S  run-mozilla.sh:18542 [ffff8101303a9100, 119] (not blocked on mutex)
S     firefox-bin:18551 [ffff8101347e5820, 115] (not blocked on mutex)
S     firefox-bin:18554 [ffff8101187fd080, 116] (not blocked on mutex)
S     firefox-bin:18555 [ffff81010d9ee820, 115] (not blocked on mutex)
S        gconfd-2:18557 [ffff810115a12860, 116] (not blocked on mutex)
S       kio_imap4:18614 [ffff810122f0f040, 116] (not blocked on mutex)
S             ssh:18637 [ffff8101100857a0, 115] (not blocked on mutex)
R         nfslock:18675 [ffff810101e0e0c0, 124] (not blocked on mutex)

---------------------------
| showing all locks held: |
---------------------------

#001:             [ffff81013251fd58] {initialize_tty_struct}
.. held by:          mingetty: 2840 [ffff81012b94d0c0, 122]
... acquired at:               read_chan+0x221/0x64e

#002:             [ffff8101304e6558] {initialize_tty_struct}
.. held by:          mingetty: 2842 [ffff81012c9c47e0, 116]
... acquired at:               read_chan+0x221/0x64e

#003:             [ffff810130481d58] {initialize_tty_struct}
.. held by:          mingetty: 2841 [ffff81012c3d6040, 122]
... acquired at:               read_chan+0x221/0x64e

#004:             [ffff810130482d58] {initialize_tty_struct}
.. held by:          mingetty: 2850 [ffff81013a8d8820, 116]
... acquired at:               read_chan+0x221/0x64e

#005:             [ffff81011e2f5d58] {initialize_tty_struct}
.. held by:              bash:19560 [ffff8100a9ab5820, 125]
... acquired at:               read_chan+0x221/0x64e

#006:             [ffff810072971d58] {initialize_tty_struct}
.. held by:              bash:19567 [ffff81008c8157a0, 125]
... acquired at:               read_chan+0x221/0x64e

#007:             [ffff81012f401558] {initialize_tty_struct}
.. held by:              bash:19539 [ffff8100694dc7e0, 116]
... acquired at:               read_chan+0x221/0x64e

#008:             [ffff81006b1d3558] {initialize_tty_struct}
.. held by:              bash:26802 [ffff810072b637e0, 116]
... acquired at:               read_chan+0x221/0x64e

#009:             [ffff81010b8bcd58] {initialize_tty_struct}
.. held by:              bash: 4032 [ffff81010b68e7e0, 116]
... acquired at:               read_chan+0x221/0x64e

#010:             [ffffffff88b063a0] {nlm_file_mutex}
.. held by:             lockd: 2607 [ffff8101385fc040, 115]
... acquired at:               nlm_traverse_files+0x20/0x109 [lockd]

=============================================

[ turning off deadlock detection. Please report this. ]
