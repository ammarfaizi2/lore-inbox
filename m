Return-Path: <linux-kernel-owner+w=401wt.eu-S932780AbXABJQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbXABJQx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 04:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932745AbXABJQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 04:16:53 -0500
Received: from mx0.karneval.cz ([81.27.192.17]:45732 "EHLO av3.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932780AbXABJQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 04:16:52 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] DocBook/HTML: Generate chapter/section level TOCs for functions
Date: Tue, 2 Jan 2007 10:18:44 +0100
User-Agent: KMail/1.9.4
Cc: tali@admingilde.org, linux-kernel@vger.kernel.org
References: <200612310227.47721.pisa@cmp.felk.cvut.cz> <20070101164147.3a6da015.rdunlap@xenotime.net>
In-Reply-To: <20070101164147.3a6da015.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021018.45360.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 January 2007 01:41, Randy Dunlap wrote:
> On Sun, 31 Dec 2006 02:27:46 +0100 Pavel Pisa wrote:
> > Simple increase of section TOC level generation significantly
> > enhances navigation experience through generated kernel
> > API documentation.
> >
> > This change restores back state from SGML tools time.
> >
> > Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> >
> > Index: linux-2.6.19/Documentation/DocBook/stylesheet.xsl
> > ===================================================================
> > --- linux-2.6.19.orig/Documentation/DocBook/stylesheet.xsl
> > +++ linux-2.6.19/Documentation/DocBook/stylesheet.xsl
> > @@ -4,4 +4,5 @@
> >  <param name="funcsynopsis.style">ansi</param>
> >  <param name="funcsynopsis.tabular.threshold">80</param>
> >  <!-- <param name="paper.type">A4</param> -->
> > +<param name="generate.section.toc.level">2</param>
> >  </stylesheet>
>
> Hi,
> Is it possible to make the TOC contain active links to their
> sections/functions?  That would be even better, wouldn't it?

Hello Randy,

this is another sort of the problem.
This problem has been probably introduced
by switch from OpenJade to xsltproc for HTML
generation as well.

I have found temporarily workaround on next
pages
  http://darkk.livejournal.com/
  http://darkk.livejournal.com/7429.html
I am attaching copy of the patch.

The copy of generated HTML documentation can be seen there

  http://cmp.felk.cvut.cz/~pisa/linux/lkdb-2.6.19.tar.gz

The problem is caused by nested <refentrytitle><phrase> tags.

XML source:

  <refentrytitle><phrase id="API-struct-x">struct x</phrase></refentrytitle>

Generates next malformed HTML with nested anchor <a> sections,
which is interpreted as link with empty text by most browsers:

  <a href="re02.html"><span><a id="API-struct-x"></a>struct x</span></a>

I do not know, if nesting of <refentrytitle><phrase> is on the
border of DocBook specification (but it seems, that it is not
against DocBook DTD) or if this is bug of xsltproc / XML -> HTML
DocBook formater. The valid HTML should read as

  <a href="re02.html" id="API-struct-x">struct x</span></a>

I has not been sure, if it is only problem of my tools set.
But is seems, that links are broken even on Free-Electrons
from 2.6.14 or may it be 2.6.12 days

  http://free-electrons.com/kerneldoc/latest/DocBook/kernel-api/

It would be good if somebody with more knowledge about
xsltproc and DocBook could help there to find clean
solution. May it be, that somebody from
  http://docbook.sourceforge.net/
could help there.

Best wishes

           Pavel Pisa


Index: linux-2.6.19/scripts/kernel-doc
===================================================================
--- linux-2.6.19.orig/scripts/kernel-doc
+++ linux-2.6.19/scripts/kernel-doc
@@ -590,7 +590,7 @@ sub output_function_xml(%) {
     print " <date>$man_date</date>\n";
     print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print " <refentrytitle><phrase id=\"$id\">".$args{'function'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle>".$args{'function'}."</refentrytitle>\n";
     print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
@@ -666,7 +666,7 @@ sub output_struct_xml(%) {
     print " <date>$man_date</date>\n";
     print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print " <refentrytitle><phrase id=\"$id\">".$args{'type'}." ".$args{'struct'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle>".$args{'type'}." ".$args{'struct'}."</refentrytitle>\n";
     print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
@@ -750,7 +750,7 @@ sub output_enum_xml(%) {
     print " <date>$man_date</date>\n";
     print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print " <refentrytitle><phrase id=\"$id\">enum ".$args{'enum'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle>enum ".$args{'enum'}."</refentrytitle>\n";
     print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
@@ -816,7 +816,7 @@ sub output_typedef_xml(%) {
     print " <date>$man_date</date>\n";
     print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print " <refentrytitle><phrase id=\"$id\">typedef ".$args{'typedef'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle>typedef ".$args{'typedef'}."</refentrytitle>\n";
     print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";

