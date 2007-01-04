Return-Path: <linux-kernel-owner+w=401wt.eu-S932359AbXADJnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbXADJnu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 04:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbXADJnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 04:43:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:45535 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932357AbXADJns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 04:43:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:references:in-reply-to:cc:disposition-notification-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aNEcbAXV0jFInxfjUExokshMWtAlcgV8gwbfjwOg/HXLkci3ejpPNzdL7u7lR1iNzifRBZ++JhA0N6dRQpD1zDzHrbbokS6/7wOaHD/kFccFNpbhq1XY2Ii7hq3P7TuYQmzEJAasftVZhk8n/79Io9WII15vUutrL1NUbQtSD24=
From: "Cyrill V. Gorcunov" <gorcunov@gmail.com>
Reply-To: gorcunov@gmail.com
To: alessandro.suardi@gmail.com
Subject: Re: qconf: reproducible segfault
Date: Thu, 4 Jan 2007 12:42:31 +0300
User-Agent: KMail/1.9.5
References: <459C1966.7040209@xs4all.nl>
In-Reply-To: <459C1966.7040209@xs4all.nl>
Cc: kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701041242.31508.gorcunov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
there is SIGSEGV happens in qconf.cc:995

	str += print_filter(sym->name);

but sym points to 0x1. To reproduce the error just do:

1) make xconfig (with Options->Show Debug Info unchecked)
2) go to Networking->Networking Options->Network packet filtering framework (Netfilter)->
   Network packet filtering framework (Netfilter) and the line "<| .." must be selected
   then just turn on Options->Show Debug info menu and you'll get:

	make[1]: *** [xconfig] Segmentation fault
	make: *** [xconfig] Error 2

gdb shows:

	Program received signal SIGSEGV, Segmentation fault.
	0x08069834 in ConfigInfoView::symbolInfo (this=0x85ae750) at qconf.cc:995
(gdb) bt
	#0  0x08069834 in ConfigInfoView::symbolInfo (this=0x85ae750) at qconf.cc:995
	#1  0x080696a9 in ConfigInfoView::setShowDebug (this=0x85ae750, b=true)
    at qconf.cc:946
	#2  0x080648bf in ConfigInfoView::qt_invoke (this=0x85ae750, _id=161, 
    _o=0xbfc56ea0) at qconf.moc:544
	#3  0xb7a5b1cc in QObject::activate_signal () from /usr/qt/3/lib/libqt-mt.so.3
	#4  0xb7a5b800 in QObject::activate_signal_bool ()
   from /usr/qt/3/lib/libqt-mt.so.3
	#5  0xb7dbd44b in QAction::toggled () from /usr/qt/3/lib/libqt-mt.so.3
	#6  0xb7ba0876 in QAction::setOn () from /usr/qt/3/lib/libqt-mt.so.3
	#7  0xb7ba0a94 in QAction::internalActivation ()
   from /usr/qt/3/lib/libqt-mt.so.3
	#8  0xb7dbd544 in QAction::qt_invoke () from /usr/qt/3/lib/libqt-mt.so.3
	#9  0xb7a5b1cc in QObject::activate_signal () from /usr/qt/3/lib/libqt-mt.so.3
	#10 0xb7d9cc7a in QSignal::signal () from /usr/qt/3/lib/libqt-mt.so.3
	#11 0xb7a753bd in QSignal::activate () from /usr/qt/3/lib/libqt-mt.so.3
	#12 0xb7b62c09 in QPopupMenu::mouseReleaseEvent ()
   from /usr/qt/3/lib/libqt-mt.so.3
	#13 0xb7a915b7 in QWidget::event () from /usr/qt/3/lib/libqt-mt.so.3
	#14 0xb79fe9df in QApplication::internalNotify ()
   from /usr/qt/3/lib/libqt-mt.so.3
	#15 0xb79fde44 in QApplication::notify () from /usr/qt/3/lib/libqt-mt.so.3
	#16 0xb79937c1 in QETWidget::translateMouseEvent ()
   from /usr/qt/3/lib/libqt-mt.so.3
	#17 0xb7991835 in QApplication::x11ProcessEvent ()
   from /usr/qt/3/lib/libqt-mt.so.3
	#18 0xb79a8bb4 in QEventLoop::processEvents ()
   from /usr/qt/3/lib/libqt-mt.so.3
	#19 0xb7a10d18 in QEventLoop::enterLoop () from /usr/qt/3/lib/libqt-mt.so.3
	#20 0xb7a10bc8 in QEventLoop::exec () from /usr/qt/3/lib/libqt-mt.so.3
	#21 0xb79fec31 in QApplication::exec () from /usr/qt/3/lib/libqt-mt.so.3
	#22 0x08074453 in main (ac=2, av=0xbfc57ac4) at qconf.cc:1736
(gdb) p sym
	$20 = (symbol *) 0x1

I'm investigating this...

-- 
	- Cyrill
