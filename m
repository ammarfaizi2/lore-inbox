Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131007AbQKTFYj>; Mon, 20 Nov 2000 00:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131129AbQKTFYa>; Mon, 20 Nov 2000 00:24:30 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:275 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131007AbQKTFYU>; Mon, 20 Nov 2000 00:24:20 -0500
Date: Sun, 19 Nov 2000 22:50:41 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        isnd4linux@listserv.isdn4linux.de, jmerkey@timpanogas.org
Subject: Re: Linux 2.2.18pre22
Message-ID: <20001119225041.C29253@vger.timpanogas.org>
In-Reply-To: <20001119015303.A25697@vger.timpanogas.org> <Pine.LNX.4.30.0011191558320.1224-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0011191558320.1224-100000@localhost.localdomain>; from kai@thphy.uni-duesseldorf.de on Sun, Nov 19, 2000 at 04:09:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii

On Sun, Nov 19, 2000 at 04:09:01PM +0100, Kai Germaschewski wrote:
> On Sun, 19 Nov 2000, Jeff V. Merkey wrote:
> 
> > > o	Small ISDN documentation fixes			(Kai Germaschewski)
> >
> > Alan, On the ISDN issue, isdn4K-utils seems to be out of sync with
> > kernels older than 2.2.16.   Some #define's that used to be in
> > the 2.2.14 patch don't seem to be in 2.2.17 >.  At present, requires
> > an ugly .config patch to work under 2.2.18-21.
> 
> It'ld be nice if you at least CC'ed your mail to the maintainers, i.e. the
> isdn4linux people, because not everyone has the time to follow l-k.
> Any way, I CC'ed isdn4linux@listserv.isdn4linux.de now, and this thread
> should continue there.
> 
> Could you please clarify which problems you have? You state that the utils
> seem to be out of sync with kernels < 2.2.16, but you need to patch them
> for kernels > 2.2.17 ?
> 
> I just tried the latest "release" of the utils,
> isdn4k-utils.v3.1pre1.tar.gz, and the current CVS version against
> 2.2.18pre22, and they compile fine. Note that binary compatibility didn't
> break during 2.2, only for 2.4. (I.e. utils compiled on 2.2 will complain
> if used with 2.4, utils compiled on 2.4 will work on either kernel series)

ISDN_MODEM_ANZREG undefined on 2.4.0-10(11) and 2.2.18-22, rpm.spec is 
attached.

Jeff



--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="isdn4k-utils.spec"

Summary: Utilities for configuring an ISDN subsystem.
Name: isdn4k-utils
Version: 3.1
Release: 1
Copyright: GPL
Group: Applications/System
Source0: ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/testing/isdn4k-utils.v3.1beta7.tar.gz
Patch0: isdn4k-utils.patch
Patch1: isdn4k-utils-ipppd.patch
BuildRoot: /var/tmp/%name-root
Requires: initscripts >= 4.93
Prereq: /sbin/chkconfig

Vendor: Timpanogas Research Group, Inc.
Packager: jmerkey@timpanogas.org

%description
The isdn4k-utils package contains a collection of utilities needed for
configuring an ISDN subsystem.

%package -n xisdnload
Version: 1.38
Summary: An ISDN connection load average display for the X Window System.
Group: Applications/System
Requires: isdn4k-utils

%description -n xisdnload
The xisdnload utility displays a periodically updated histogram of the
load average over your ISDN connection.

%prep
%setup -q -n isdn4k-utils
%patch0
%patch1
cd capi20
libtoolize --copy --force
test -f /usr/include/capi20.h || cp capi20.h /usr/include/capi20.h
cd ..


%build
cp .config.rpm .config
make RPM_OPT_FLAGS="$RPM_OPT_FLAGS" subconfig
make RPM_OPT_FLAGS="$RPM_OPT_FLAGS"

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/dev
mkdir -p $RPM_BUILD_ROOT/etc/rc.d/init.d
mkdir -p $RPM_BUILD_ROOT/etc/{ppp,isdn}
mkdir -p $RPM_BUILD_ROOT/var/{log/vbox,spool/vbox,lock/isdn}
mkdir -p $RPM_BUILD_ROOT/usr/{sbin,X11R6/bin}
chmod 1777 $RPM_BUILD_ROOT/var/spool/vbox
make install DESTDIR=$RPM_BUILD_ROOT

mv -fv $RPM_BUILD_ROOT/usr/bin/x* $RPM_BUILD_ROOT/usr/X11R6/bin/
mv -fv $RPM_BUILD_ROOT/usr/man/man1/x* $RPM_BUILD_ROOT/usr/X11R6/man/man1/

touch $RPM_BUILD_ROOT/etc/ppp/ioptions

test -f $RPM_BUILD_ROOT/etc/isdn/isdn.conf.new && \
	mv -f $RPM_BUILD_ROOT/etc/isdn/isdn.conf.new $RPM_BUILD_ROOT/etc/isdn/isdn.conf

strip $RPM_BUILD_ROOT/usr/bin/* $RPM_BUILD_ROOT/usr/sbin/* \
	$RPM_BUILD_ROOT/usr/X11R6/bin/*  || :

# build some more documentation
pushd FAQ/tutorial ; {
    sgml2txt EN-i4l.sgml
    sgml2html EN-i4l.sgml
} ; popd

chmod 0755 $RPM_BUILD_ROOT/usr/bin/vboxbeep

%post
test -f /dev/isdnctrl || ln -sf isdnctrl0 /dev/isdnctrl

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root)
%dir /etc/isdn
%dir /var/spool/vbox
%dir /var/log/vbox
%verify(not md5 size mtime) %config(noreplace) /etc/isdn/*
/etc/ppp/ioptions
/usr/bin/*
/usr/include/*
/usr/lib/*.a
/usr/lib/*.so.*
/usr/man/man?/*
/usr/sbin/*
%doc COPYING HOWTO README
%lang(de) %doc vbox/doc/de/vbox.sgml vbox/doc/de/vbox.txt
%doc FAQ/tutorial/EN-i4l*  FAQ/i4lfaq* Mini-FAQ/* FAQ/_howto/* FAQ/_example/*
#%lang(de) %doc FAQ/out/de-i4l-faq.asc FAQ/out/de-i4l-faq.html
%doc FAQ/_howto FAQ/_example FAQ/tutorial/*.txt FAQ/tutorial/*.html

%files -n xisdnload
%defattr(-,root,root)
/usr/X11R6/bin/xisdnload
%attr(0755,root,root) /usr/X11R6/bin/xmonisdn
/usr/X11R6/lib/X11/app-defaults/*
/usr/X11R6/man/man1/*
/usr/X11R6/include/X11/bitmaps/*
%doc xmonisdn/README

%changelog

--TB36FDmn/VVEgNH/--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
