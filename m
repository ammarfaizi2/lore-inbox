Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317457AbSGEMnL>; Fri, 5 Jul 2002 08:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSGEMnK>; Fri, 5 Jul 2002 08:43:10 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:48067 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S317457AbSGEMnI>; Fri, 5 Jul 2002 08:43:08 -0400
Subject: Init Skript / RPM =?ISO-8859-1?Q?f=FCr?= SuSE & RedHat
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-4IsfKqKReJRI/ElTnTdh"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jul 2002 14:46:47 +0200
Message-Id: <1025873207.30422.29.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4IsfKqKReJRI/ElTnTdh
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Das hier ist sicherlich keine endg=FCltige L=F6sung, aber es zeigt
im Prinzip, wie man die Distributions-Unterschiede im init.d Skript bzw.
SPEC-file abfangen kann.

--=20
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





--=-4IsfKqKReJRI/ElTnTdh
Content-Description: Specfile
Content-Disposition: attachment; filename=ftrksnmp.spec
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-15

Summary: SNMP daemon for monitoring the Promise FastTrak RAID controller
Name: ftrksnmp
Version: 1.31.0064
Release: 4fsc
URL: http://www.promise.com
Source0: %{name}-%{version}.tar.gz
License: Commercial
Group:  System Environment/Daemons=20
Vendor: Promise Technology
Packager: Fujitsu Siemens Computers
BuildRoot: %{_tmppath}/%{name}-root

%description
This SNMP agent can be used in connection with an SNMP daemon
(ucd-snmp or the Fujitsu Siemens Servermanagement SNMP package)
for remote monitoring and control of the operation of the Promise
FastTrak (TM) IDE RAID controllers.

It requires the Promise FastTrak (TM) driver version 1.2.0 build 15
to be installed for proper operation.

%prep
%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT
install -d -m 755 $RPM_BUILD_ROOT/{/etc/rc.d/init.d,/usr/sbin,/usr/share/sn=
mp/mibs,/var/adm/fillup-templates}
install -m 644 FASTTRAK-MIB.txt $RPM_BUILD_ROOT/usr/share/snmp/mibs
install -m 755 ftsnmpd $RPM_BUILD_ROOT/usr/sbin
install -m 755 ftstart $RPM_BUILD_ROOT/etc/rc.d/init.d
install -m 644 rc.config.ftsnmpd $RPM_BUILD_ROOT/var/adm/fillup-templates

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%dir /etc/rc.d/init.d
%dir /usr/share/snmp/mibs
%dir /var/adm/fillup-templates
/usr/share/snmp/mibs/FASTTRAK-MIB.txt
/usr/sbin/ftsnmpd
/var/adm/fillup-templates/rc.config.ftsnmpd
%config /etc/rc.d/init.d/ftstart
%doc README

%post
if [ -f /etc/rc.d/init.d/functions ]; then
   [ -x /sbin/chkconfig ] && /sbin/chkconfig --add ftstart
elif [ -f /etc/rc.config ]; then
   ln -s ../rc.d/init.d/ftstart /etc/init.d/ftstart
   [ -x sbin/insserv ] && sbin/insserv /etc/init.d/ftstart
   [ -x bin/fillup ] && bin/fillup -q etc/rc.config var/adm/fillup-template=
s/rc.config.ftsnmpd
fi
exit 0

%preun
/etc/rc.d/init.d/ftstart stop
exit 0
  =20
%postun
if [ -f /etc/rc.d/init.d/functions ]; then
   [ -x /sbin/chkconfig ] && /sbin/chkconfig --del ftstart
elif [ -f /etc/rc.config ]; then
   rm -f /etc/init.d/ftstart
   [ -x sbin/insserv ] && sbin/insserv /etc/init.d
fi
exit 0


%changelog
* Fri Jul  5 2002 Martin Wilck <martin.wilck@fujitsu-siemens.com>
- Initial build.



--=-4IsfKqKReJRI/ElTnTdh
Content-Description: Init skript
Content-Disposition: attachment; filename=ftstart
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-sh; charset=ISO-8859-15

#!/bin/sh
#
# chkconfig: 345 95 40
#
# description: SNMP daemon for the FastTrak product line
#
# processname: ftsnmpd
# Source function library.

### BEGIN INIT INFO
# Provides:     =20
# Required-Start: snmp
# Required-Stop:
# Default-Start:  3 4 5
# Default-Stop:   0 1 2 6
# Description:   SNMP daemon for the FastTrak product line=20
### END INIT INFO

FTSNMPD=3D/usr/sbin/ftsnmpd

killproc_rh () {
        local proc=3D$1
        local sig=3D$2
	killproc $proc $sig
}

killproc_suse () {
        local proc=3D$1
        local sig=3D$2
	killproc $sig $proc
}

if [ -f /etc/rc.d/init.d/functions ]; then
# RedHat
    . /etc/rc.d/init.d/functions
    START=3Ddaemon
    STOP=3Dkillproc_rh
    STATUS=3Dstatus $FTSNMPD
elif [ -f /etc/rc.config ]; then
# SusE
    . /etc/rc.config
    [ "x$START_FTSNMPD" =3D "xyes" ] || exit 0
    . /etc/rc.status
    START=3Dstartproc
    STOP=3Dkillproc_suse
    STATUS=3D"rc_status -v"
else
    echo "Cannot determine distribution" >&2
    exit 1
fi   =20

# See how we were called.
case "$1" in
  start)
	echo -n "Starting ftsnmpd: "
	$START $FTSNMPD
	$STATUS
	;;
  stop)
	echo -n "Stopping ftsnmpd: "
	$STOP $FTSNMPD "-15"
	$STATUS
	;;
  status)
	$STATUS
	;;
  restart|reload)
	$0 stop
	$0 start
	;;
=09
  *)
	exit 1
esac

--=-4IsfKqKReJRI/ElTnTdh--

