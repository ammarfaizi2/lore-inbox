Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271154AbTHCKn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271152AbTHCKn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:43:27 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:57063 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP id S271191AbTHCKnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:43:23 -0400
Message-ID: <00b901c359ac$0c7fe0a0$322bde50@koticompaq>
From: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
To: <linux-kernel@vger.kernel.org>
References: <009201c3599f$04ff05c0$322bde50@koticompaq> <20030803022723.760f6451.akpm@osdl.org>
Subject: Re: 2.6.0-test2-mm3 and mysql
Date: Sun, 3 Aug 2003 13:43:12 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

----- Original Message ----- 
From: "Andrew Morton" <akpm@osdl.org>
To: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, August 03, 2003 12:27 PM
Subject: Re: 2.6.0-test2-mm3 and mysql

> "Heikki Tuuri" <Heikki.Tuuri@innodb.com> wrote:
> >
> > What to do? People who write drivers should run heavy, multithreaded
file
> >  i/o tests on their computer using some SQL database which calls
fsync(). For
> >  example, run the Perl '/sql-bench/innotest's all concurrently on MySQL.
If
> >  the problems are in drivers, that could help.
>
> Well there's a problem.  We're kernel people, not database people.  I, for
> one, would not have a clue how to set such a thing up.
>
> If someone could prepare a simple-enough-for-kernel-people description of
> how to get such a test up and running, then we might make some progress.

ok :).

1. Download

from http://www.mysql.com/downloads/mysql-4.0.html:

MySQL-server-VERSION.i386.rpm The MySQL server. You will need this unless
you only want to connect to a MySQL server running on another machine.
Please note that this package was called MySQL-VERSION.i386.rpm before MySQL
4.0.10.

MySQL-client-VERSION.i386.rpm The standard MySQL client programs. You
probably always want to install this package.

MySQL-bench-VERSION.i386.rpm Tests and benchmarks. Requires Perl and the
DBD-mysql module.

MySQL-shared-compat-VERSION.i386.rpm This package includes the shared
libraries for both MySQL 3.23 and MySQL 4.0. Install this package instead of
MySQL-shared, if you have applications installed that are dynamically linked
against MySQL 3.23 but you want to upgrade to MySQL 4.0 without breaking the
library dependencies. This package is available since MySQL 4.0.13.
(these are named 'Dynamic client libraries (including 3.23.x libraries)' on
the download page).

Do NOT use the MySQL distro which comes with Red Hat distros. It is old and
may not be properly built. Only use binaries downloaded from www.mysql.com.

2. Install with

shell> rpm -i MySQL-server-VERSION.i386.rpm MySQL-client-VERSION.i386.rpm

etc.

3. I am assuming that you have Perl which comes in most Linux distros. You
probably also have the MySQL DBI/DBD module in your Linux distro. It will
use those MySQL-shared-compat client libraries.

http://search.cpan.org/author/JWIED/DBD-mysql-2.1026/lib/DBD/mysql/INSTALL.pod:
"
Red Hat Linux

As of version 7.1, Red Hat Linux comes with MySQL and DBD::mysql. You need
to ensure that the following RPM's are installed:
  mysql
  perl-DBI
  perl-DBD-MySQL
"

If you do not have DBI/DBD, you have to resort to
http://www.mysql.com/downloads/api-dbi.html.

4. The rpm installation should now have the mysqld daemon running and mysqld
etc. placed in a bin dir (probably /usr/bin). You can shut it down with

mysqladmin shutdown

You can start it again with

mysqld

it should print something like:

"
030803 13:13:48  InnoDB: Started
mysqld: ready for connections.
Version: '4.0.14-debug-log'  socket: '/home/heikki/MySQLheikki'  port: 3307
"

(If something went wrong in the grants table creation, it will complain it
cannot find the 'host.frm' file. In that case refer to
http://www.mysql.com/doc/en/Post-installation.html about the script
mysql_install_db.)

The 'datadir' of MySQL is typically /var/lib/mysql. Under it is the actual
database data.

To connect to the database from a console, type

mysql test

mysql> show databases;
...
mysql> exit

5. To run Perl tests, go to the sql-bench directory (typically under
/usr/local/mysql) and:

perl innotest1

perl innotest1a

perl run-all-tests --create-options=type=innodb

etc.

You should run all innotests concurrently.

mysqld should not crash or print anything. The Perl tests themselves print
quite a lot as they test deadlocks etc.

We are testing a Pogo Linux server with a Red Hat 2.4.20 kernel,
http://www.mysql.com/press/release_2003_20.html, and so far that combination
seems to work ok.

Greetings to Linus! I hope you are having a good time at OSDL!

Heikki


