Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262109AbRE3Ug0>; Wed, 30 May 2001 16:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbRE3UgS>; Wed, 30 May 2001 16:36:18 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:46097 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262170AbRE3UgE>; Wed, 30 May 2001 16:36:04 -0400
Date: Wed, 30 May 2001 22:35:35 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Tim Waugh <twaugh@redhat.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Procfs Guide
Message-ID: <20010530223535.A11197@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010530012917.E31655@arthur.ubicom.tudelft.nl> <20010530093048.O1332@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010530093048.O1332@redhat.com>; from twaugh@redhat.com on Wed, May 30, 2001 at 09:30:48AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 09:30:48AM +0100, Tim Waugh wrote:
> On Wed, May 30, 2001 at 01:29:17AM +0200, Erik Mouw wrote:
> > I'm still looking for a proper way to automatically include the example
> > source into the SGML file, this patch with the same content in two
> > files is a bit of an ugly hack.
> 
> Probably your best bet is to get the Makefile to pass a copy of the
> real example source through sed to &entity;ify the bits that would
> confuse SGML (<, >, etc), and into example.c.sed, make that into an
> entity, and include it.
> 
> See <URL:http://people.redhat.com/twaugh/docbook/selfdocbook/> for
> instance, which does this with its own SGML source.

Thanks, that was a really helpful example.

So how about this version?


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/


Index: Documentation/DocBook/Makefile
===================================================================
RCS file: /home/erik/cvsroot/elinux/Documentation/DocBook/Makefile,v
retrieving revision 1.1.1.30
retrieving revision 1.1.1.25.2.2
diff -u -r1.1.1.30 -r1.1.1.25.2.2
--- Documentation/DocBook/Makefile	2001/05/15 12:14:07	1.1.1.30
+++ Documentation/DocBook/Makefile	2001/05/30 20:31:18	1.1.1.25.2.2
@@ -1,7 +1,7 @@
 BOOKS	:= wanbook.sgml z8530book.sgml mcabook.sgml videobook.sgml \
 	   kernel-api.sgml parportbook.sgml kernel-hacking.sgml \
 	   kernel-locking.sgml via-audio.sgml mousedrivers.sgml sis900.sgml \
-	   deviceiobook.sgml
+	   deviceiobook.sgml procfs-guide.sgml
 
 PS	:=	$(patsubst %.sgml, %.ps, $(BOOKS))
 PDF	:=	$(patsubst %.sgml, %.pdf, $(BOOKS))
@@ -9,6 +9,7 @@
 IMG-parportbook := parport-share.fig parport-multi.fig parport-structure.fig
 EPS-parportbook := $(patsubst %.fig, %.eps, $(IMG-parportbook))
 JPG-parportbook := $(patsubst %.fig, %.jpeg, $(IMG-parportbook))
+C-procfs-example = procfs_example.sgml
 
 books:	$(BOOKS)
 
@@ -67,6 +68,17 @@
 	$(TOPDIR)/scripts/docgen $(TOPDIR)/drivers/media/video/videodev.c \
 		<videobook.tmpl >videobook.sgml
 
+procfs_example.sgml: procfs_example.c
+	echo "<programlisting>" > $@
+	expand --tabs=8 < $< | \
+	sed -e "s/&/\\&amp;/g" \
+	    -e "s/</\\&lt;/g" \
+	    -e "s/>/\\&gt;/g" >> $@
+	echo "</programlisting>" >> $@
+
+procfs-guide.sgml:  procfs-guide.tmpl procfs_example.sgml
+	$(TOPDIR)/scripts/docgen < procfs-guide.tmpl >$@
+
 APISOURCES :=	$(TOPDIR)/drivers/media/video/videodev.c \
 		$(TOPDIR)/arch/i386/kernel/irq.c \
 		$(TOPDIR)/arch/i386/kernel/mca.c \
@@ -128,6 +140,7 @@
 	-$(RM) $(BOOKS)
 	-$(RM) $(DVI) $(AUX) $(TEX) $(LOG) $(OUT)
 	-$(RM) $(JPG-parportbook) $(EPS-parportbook)
+	-$(RM) $(C-procfs-example)
 
 mrproper: clean
 	-$(RM) $(PS) $(PDF)
Index: Documentation/DocBook/procfs-guide.tmpl
===================================================================
RCS file: procfs-guide.tmpl
diff -N procfs-guide.tmpl
--- /dev/null	Thu Mar 22 14:04:47 2001
+++ Documentation/DocBook/procfs-guide.tmpl	Wed May 30 22:32:02 2001
@@ -0,0 +1,603 @@
+<!-- -*- sgml -*- -->
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[
+<!ENTITY procfsexample SYSTEM "procfs_example.sgml">
+]>
+
+<book id="LKProcfsGuide">
+  <bookinfo>
+    <title>Linux Kernel Procfs Guide</title>
+
+
+    <authorgroup>
+      <author>
+	<firstname>Erik</firstname>
+	<othername>(J.A.K.)</othername>
+	<surname>Mouw</surname>
+	<affiliation>
+	  <orgname>Delft University of Technology</orgname>
+	  <orgdiv>Faculty of Information Technology and Systems</orgdiv>
+	  <address>
+            <email>J.A.K.Mouw@its.tudelft.nl</email>
+            <pob>PO BOX 5031</pob>
+            <postcode>2600 GA</postcode>
+            <city>Delft</city>
+            <country>The Netherlands</country>
+          </address>
+	</affiliation>
+      </author>
+    </authorgroup>
+
+
+    <copyright>
+      <year>2001</year>
+      <holder>Erik Mouw</holder>
+    </copyright>
+
+
+    <legalnotice>
+      <para>
+        This documentation is free software; you can redistribute it
+        and/or modify it under the terms of the GNU General Public
+        License as published by the Free Software Foundation; either
+        version 2 of the License, or (at your option) any later
+        version.
+      </para>
+      
+      <para>
+        This documentation is distributed in the hope that it will be
+        useful, but WITHOUT ANY WARRANTY; without even the implied
+        warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+        PURPOSE.  See the GNU General Public License for more details.
+      </para>
+      
+      <para>
+        You should have received a copy of the GNU General Public
+        License along with this program; if not, write to the Free
+        Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+        MA 02111-1307 USA
+      </para>
+      
+      <para>
+        For more details see the file COPYING in the source
+        distribution of Linux.
+      </para>
+    </legalnotice>
+  </bookinfo>
+
+
+
+
+  <toc>
+  </toc>
+
+
+
+
+  <preface>
+    <title>Preface</title>
+
+    <para>
+      This guide describes the use of the procfs file system from
+      within the Linux kernel. The idea to write this guide came up on
+      the #kernelnewbies IRC channel (see <ulink
+      url="http://www.kernelnewbies.org/">http://www.kernelnewbies.org/</ulink>),
+      when Jeff Garzik explained the use of procfs and forwarded me a
+      message Alexander Viro wrote to the linux-kernel mailing list. I
+      agreed to write it up nicely, so here it is.
+    </para>
+
+    <para>
+      I'd like to thank Jeff Garzik
+      <email>jgarzik@mandrakesoft.com</email> and Alexander Viro
+      <email>viro@math.psu.edu</email> for their input, and Tim Waugh
+      <email>twaugh@redhat.com</email> for his <ulink
+      url="http://people.redhat.com/twaugh/docbook/selfdocbook/">Selfdocbook</ulink>.
+    </para>
+
+    <para>
+      This documentation was written while working on the LART
+      computing board (<ulink
+      url="http://www.lart.tudelft.nl/">http://www.lart.tudelft.nl/</ulink>).
+      The development has been sponsored by the Mobile Multi-media
+      Communications (<ulink
+      url="http://www.mmc.tudelft.nl/">http://www.mmc.tudelft.nl/</ulink>)
+      and Ubiquitous Communications (<ulink
+      url="http://www.ubicom.tudelft.nl/">http://www.ubicom.tudelft.nl/</ulink>)
+      projects.
+    </para>
+
+    <para>
+      Erik
+    </para>
+  </preface>
+
+
+
+
+  <chapter id="intro">
+    <title>Introduction</title>
+
+    <para>
+      The <filename class="directory">/proc</filename> file system
+      (procfs) is a special file system in the linux kernel. It's a
+      virtual file system: it is not associated with a block device but
+      exists only in memory. The files in the procfs are used to allow
+      userland programs access to certain information from the kernel
+      (like process information in <filename
+      class="directory">/proc/[0-9]+/</filename>), but also for debug
+      purposes (like <filename>/proc/ksyms</filename>).
+    </para>
+
+    <para>
+      This guide describes the use of the procfs file system from
+      within the Linux kernel. It starts by introducing all relevant
+      functions to manage the files within the file system. After that
+      it shows how to communicate with userland, and some tips and
+      tricks will be pointed out. Finally a complete example will be
+      shown.
+    </para>
+  </chapter>
+
+
+
+
+  <chapter id="managing">
+    <title>Managing procfs entries</title>
+    
+    <para>
+      This chapter describes the functions that various kernel
+      components use to populate the procfs with files, symlinks,
+      device nodes, and directories.
+    </para>
+
+    <para>
+      A minor note before we start: if you want to use any of the
+      procfs functions, be sure to include the correct header file! 
+      This should be one of the first lines in your code:
+    </para>
+
+    <programlisting>
+#include &lt;linux/proc_fs.h&gt;
+    </programlisting>
+
+
+
+
+    <sect1 id="regularfile">
+      <title>Creating a regular file</title>
+      
+      <funcsynopsis>
+	<funcprototype>
+	  <funcdef>struct proc_dir_entry* <function>create_proc_entry</function></funcdef>
+	  <paramdef>const char* <parameter>name</parameter></paramdef>
+	  <paramdef>mode_t <parameter>mode</parameter></paramdef>
+	  <paramdef>struct proc_dir_entry* <parameter>parent</parameter></paramdef>
+	</funcprototype>
+      </funcsynopsis>
+
+      <para>
+        This function creates a regular file with the name
+        <parameter>name</parameter>, file mode
+        <parameter>mode</parameter> in the directory
+        <parameter>parent</parameter>. To create a file in the root of
+        the procfs, use <constant>NULL</constant> as
+        <parameter>parent</parameter> parameter. When successful, the
+        function will return a pointer to the freshly created
+        <structname>struct proc_dir_entry</structname>; otherwise it
+        will return <constant>NULL</constant>. <xref
+        linkend="userland"> describes how to do something useful with
+        regular files.
+      <para>
+
+      <para>
+        Note that it is specifically supported that you can pass a
+        multi-directory path. For example
+        <function>create_proc_entry</function>(<parameter>"drivers/via0/info"</parameter>)
+        will create the <filename class="directory">via0</filename>
+        directory if necessary, with standard
+        <constant>0755</constant> permissions.
+      </para>
+
+    <para>
+      If you only want to be able to read the file, the function
+      <function>create_proc_read_entry</function> described in <xref
+      linkend="convenience"> might be used to create and initialise
+      the procfs entry in one single call.
+    </para>
+    </sect1>
+
+
+
+
+    <sect1>
+      <title>Creating a symlink</title>
+
+      <funcsynopsis>
+	<funcprototype>
+	  <funcdef>struct proc_dir_entry*
+	  <function>proc_symlink</function></funcdef> <paramdef>const
+	  char* <parameter>name</parameter></paramdef>
+	  <paramdef>struct proc_dir_entry*
+	  <parameter>parent</parameter></paramdef> <paramdef>const
+	  char* <parameter>dest</parameter></paramdef>
+	</funcprototype>
+      </funcsynopsis>
+      
+      <para>
+        This creates a symlink in the procfs directory
+        <parameter>parent</parameter> that points from
+        <parameter>name</parameter> to
+        <parameter>dest</parameter>. This translates in userland to
+        <literal>ln -s</literal> <parameter>dest</parameter>
+        <parameter>name</parameter>.
+      </para>
+    </sect1>
+
+
+
+
+    <sect1>
+      <title>Creating a device</title>
+
+      <funcsynopsis>
+	<funcprototype>
+	  <funcdef>struct proc_dir_entry* <function>proc_mknod</function></funcdef>
+	  <paramdef>const char* <parameter>name</parameter></paramdef>
+	  <paramdef>mode_t <parameter>mode</parameter></paramdef>
+	  <paramdef>struct proc_dir_entry* <parameter>parent</parameter></paramdef>
+	  <paramdef>kdev_t <parameter>rdev</parameter></paramdef>
+	</funcprototype>
+      </funcsynopsis>
+      
+      <para>
+        Creates a device file <parameter>name</parameter> with mode
+        <parameter>mode</parameter> in the procfs directory
+        <parameter>parent</parameter>. The device file will work on
+        the device <parameter>rdev</parameter>, which can be generated
+        by using the <literal>MKDEV</literal> macro from
+        <literal>linux/kdev_t.h</literal>. The
+        <parameter>mode</parameter> parameter
+        <emphasis>must</emphasis> contain <constant>S_IFBLK</constant>
+        or <constant>S_IFCHR</constant> to create a device
+        node. Compare with userland <literal>mknod
+        --mode=</literal><parameter>mode</parameter>
+        <parameter>name</parameter> <parameter>rdev</parameter>.
+      </para>
+    </sect1>
+
+
+
+
+    <sect1>
+      <title>Creating a directory</title>
+      
+      <funcsynopsis>
+	<funcprototype>
+	  <funcdef>struct proc_dir_entry* <function>proc_mkdir</function></funcdef>
+	  <paramdef>const char* <parameter>name</parameter></paramdef>
+	  <paramdef>struct proc_dir_entry* <parameter>parent</parameter></paramdef>
+	</funcprototype>
+      </funcsynopsis>
+
+      <para>
+        Create a directory <parameter>name</parameter> in the procfs
+        directory <parameter>parent</parameter>.
+      </para>
+    </sect1>
+
+
+
+
+    <sect1>
+      <title>Removing an entry</title>
+      
+      <funcsynopsis>
+	<funcprototype>
+	  <funcdef>void <function>remove_proc_entry</function></funcdef>
+	  <paramdef>const char* <parameter>name</parameter></paramdef>
+	  <paramdef>struct proc_dir_entry* <parameter>parent</parameter></paramdef>
+	</funcprototype>
+      </funcsynopsis>
+
+      <para>
+        Removes the entry <parameter>name</parameter> in the directory
+        <parameter>parent</parameter> from the procfs. Note that
+        entries are removed by their <emphasis>name</emphasis>, not by
+        the <structname>struct proc_dir_entry</structname> returned by the
+        various create functions.
+      </para>
+      
+      <para>
+        Note that the <structfield>data</structfield> entry from the
+        <structname>struct proc_dir_entry</structname>> has to be freed
+        before this function is called (that is: if there was some
+        <structfield>data</structfield> allocated, of course). See
+        <xref linkend="usingdata"> for more information on using the
+        <structfield>data</structfield> entry.
+      </para>
+    </sect1>
+  </chapter>
+
+
+
+
+  <chapter id="userland">
+    <title>Communicating with userland</title>
+    
+    <para>
+       Instead of reading (or writing) the information directly from
+       kernel memory, the procfs works with <emphasis>call back
+       functions</emphasis> for files: functions that are called when
+       a specific file is being read or written. Those functions have
+       to be initialised after the procfs file is created by setting
+       the <structfield>read_proc</structfield> and/or
+       <structfield>write_proc</structfield> fields in the
+       <structname>struct proc_dir_entry*</structname> the function
+       <function>create_proc_entry</function> returned:
+    </para>
+
+    <programlisting>
+struct proc_dir_entry* entry;
+
+entry->read_proc = read_proc_foo;
+entry->write_proc = write_proc_foo;
+    </programlisting>
+
+    <para>
+      If you only want to use a the
+      <structfield>read_proc</structfield>, the function
+      <function>create_proc_read_entry</function> described in <xref
+      linkend="convenience"> might be used to create and initialise
+      the procfs entry in one single call.
+    </para>
+
+
+
+    <sect1>
+      <title>Reading data</title>
+
+      <para>
+        The read function is a call back function that allows userland
+        processes to read data from the kernel. The read function
+        should have the following format:
+      </para>
+
+      <funcsynopsis>
+	<funcprototype>
+	  <funcdef>int <function>read_func</function></funcdef>
+	  <paramdef>char* <parameter>page</parameter></paramdef>
+	  <paramdef>char** <parameter>start</parameter></paramdef>
+	  <paramdef>off_t <parameter>off</parameter></paramdef>
+	  <paramdef>int <parameter>count</parameter></paramdef>
+	  <paramdef>int* <parameter>eof</parameter></paramdef>
+	  <paramdef>void* <parameter>data</parameter></paramdef>
+	</funcprototype>
+      </funcsynopsis>
+
+      <para>
+        The read function should write its information into the
+        <parameter>page</parameter>. For proper use, the function
+        should start writing at an offset of
+        <parameter>off</parameter> in <parameter>page</parameter> and
+        write <parameter>count</parameter> bytes at maximum, but
+        because most read functions are quite simple and only return a
+        small amount of information, these two parameters are usually
+        ignored (it breaks pagers like <literal>more</literal> and
+        <literal>less</literal>, but <literal>cat</literal> still
+        works).
+      </para>
+
+      <para>
+        If the <parameter>off</parameter> and
+        <parameter>count</parameter> parameters are properly used,
+        <parameter>eof</parameter> should be used to signal that the
+        end of the file has been reached by writing
+        <literal>1</literal> to the memory location
+        <parameter>eof</parameter> points to.
+      </para>
+
+      <para>
+        The parameter <parameter>start</parameter> doesn't seem to be
+        used anywhere in the kernel. The <parameter>data</parameter>
+        parameter can be used to use a single call back function for
+        several files, see <xref linkend="usingdata">.
+      </para>
+
+      <para>
+        The <function>read_func</function> function must return the
+        number of bytes written into the <parameter>page</parameter>.
+      </para>
+
+      <para>
+        <xref linkend="example"> shows how to use a read call back
+        function.
+      </para>
+    </sect1>
+
+
+
+
+    <sect1>
+      <title>Writing data</title>
+
+      <para>
+        The write call back function allows a userland process to write
+        data to the kernel, so it has some kind of control over the
+        kernel. The write function should have the following format:
+      </para>
+
+      <funcsynopsis>
+	<funcprototype>
+	  <funcdef>int <function>write_func</function></funcdef>
+	  <paramdef>struct file* <parameter>file</parameter></paramdef>
+	  <paramdef>const char* <parameter>buffer</parameter></paramdef>
+	  <paramdef>unsigned long <parameter>count</parameter></paramdef>
+	  <paramdef>void* <parameter>data</parameter></paramdef>
+	</funcprototype>
+      </funcsynopsis>
+
+      <para>
+        The write function should read <parameter>count</parameter>
+        bytes at maximum from the <parameter>buffer</parameter>. Note
+        that the <parameter>buffer</parameter> doesn't live in the
+        kernel's memory space, so it should first be copied to kernel
+        space with <function>copy_from_user</function>. The
+        <parameter>file</parameter> parameter is usually
+        ignored. <xref linkend="usingdata"> shows how to use the
+        <parameter>data</parameter> parameter.
+      </para>
+
+      <para>
+        Again, <xref linkend="example"> shows how to use this call back
+        function.
+      </para>
+    </sect1>
+
+
+
+
+    <sect1 id="usingdata">
+      <title>A single call back for many files</title>
+
+      <para>
+         When a large number of almost identical files is used, it's
+         quite inconvenient to use a separate call back function for
+         each file. Instead of that, a single call back function can be
+         used that distinguishes between the files by using
+         <structfield>data</structfield> field in <structname>struct
+         proc_dir_entry</structname>. First of all, the
+         <structfield>data</structfield> field has to be initialised:
+      </para>
+
+      <programlisting>
+struct proc_dir_entry* entry;
+struct my_file_data *file_data;
+
+file_data = kmalloc(sizeof(struct my_file_data), GFP_KERNEL);
+entry->data = file_data;
+      </programlisting>
+     
+      <para>
+          The <structfield>data</structfield> field is a <type>void
+          *</type>, so it can be initialised with anything.
+      </para>
+
+      <para>
+        Now that the <structfield>data</structfield> field is set, the
+        <function>read_proc</function> and
+        <function>write_proc</function> can use it to distinguish
+        between files because they get it passed into their
+        <parameter>data</parameter> parameter:
+      </para>
+
+      <programlisting>
+int foo_read_func(char *page, char **start, off_t off,
+                  int count, int *eof, void *data)
+{
+        int len;
+
+        if(data == file_data) {
+                /* special case for this file */
+        } else {
+                /* normal processing */
+        }
+
+        return len;
+}
+      </programlisting>
+
+      <para>
+        Be sure to free the <structfield>data</structfield> data field
+        when removing the procfs entry.
+      </para>
+    </sect1>
+  </chapter>
+
+
+
+
+  <chapter id="tips">
+    <title>Tips and tricks</title>
+
+
+
+
+    <sect1 id="convenience">
+      <title>Convenience functions</title>
+
+      <funcsynopsis>
+	<funcprototype>
+	  <funcdef>struct proc_dir_entry* <function>create_proc_read_entry</function></funcdef>
+	  <paramdef>const char* <parameter>name</parameter></paramdef>
+	  <paramdef>mode_t <parameter>mode</parameter></paramdef>
+	  <paramdef>struct proc_dir_entry* <parameter>parent</parameter></paramdef>
+	  <paramdef>read_proc_t* <parameter>read_proc</parameter></paramdef>
+	  <paramdef>void* <parameter>data</parameter></paramdef>
+	</funcprototype>
+      </funcsynopsis>
+      
+      <para>
+        This function creates a regular file in exactly the same way
+        as <function>create_proc_entry</function> from <xref
+        linkend="regularfile"> does, but also allows to set the read
+        function <parameter>read_proc</parameter> in one call. This
+        function is also able to set the <parameter>data</parameter>,
+        as explained in <xref linkend="usingdata">.
+      </para>
+    </sect1>
+
+
+
+    <sect1>
+      <title>Modules</title>
+
+      <para>
+        If the procfs is being used from within a module, be sure to
+        set the <structfield>owner</structfield> field in the
+        <structname>struct proc_dir_entry</structname> to
+        <constant>THIS_MODULE</constant>.
+      <para>
+
+      <programlisting>
+struct proc_dir_entry* entry;
+
+entry->owner = THIS_MODULE;
+      </programlisting>
+    </sect1>
+
+
+
+
+    <sect1>
+      <title>Mode and ownership</title>
+
+      <para>
+        Sometimes it is useful to change the mode and/or ownership of a
+        procfs entry. Here is an example how to achieve that:
+      </para>
+
+      <programlisting>
+struct proc_dir_entry* entry;
+
+entry->mode =  S_IWUSR |S_IRUSR | S_IRGRP | S_IROTH;
+entry->uid = 0;
+entry->gid = 100;
+      </programlisting>
+
+    </sect1>
+  </chapter>
+
+
+
+
+  <chapter id="example">
+    <title>Example</title>
+
+    <!-- be careful with the example code: it shouldn't be wider than
+    approx. 60 columns, or otherwise it won't fit properly on a page
+    -->
+
+&procfsexample;
+
+  </chapter>
+</book>
Index: Documentation/DocBook/procfs_example.c
===================================================================
RCS file: procfs_example.c
diff -N procfs_example.c
--- /dev/null	Thu Mar 22 14:04:47 2001
+++ Documentation/DocBook/procfs_example.c	Wed May 30 22:32:02 2001
@@ -0,0 +1,247 @@
+/*
+ * procfs_example.c: an example proc interface
+ *
+ * Copyright (C) 2001, Erik Mouw (J.A.K.Mouw@its.tudelft.nl)
+ *
+ * This file accompanies the procfs-guide in the Linux kernel
+ * source. It's main use is to demonstrate the concepts and
+ * functions described in the guide.
+ *
+ * This software has been developed while working on the LART
+ * computing board (http://www.lart.tudelft.nl/). The
+ * development has been sponsored by the Mobile Multi-media
+ * Communications (http://www.mmc.tudelft.nl/) and Ubiquitous
+ * Communications (http://www.ubicom.tudelft.nl/) projects.
+ *
+ * The author can be reached at:
+ *
+ *  Erik Mouw
+ *  Information and Communication Theory Group
+ *  Faculty of Information Technology and Systems
+ *  Delft University of Technology
+ *  P.O. Box 5031
+ *  2600 GA Delft
+ *  The Netherlands
+ *
+ *
+ * This program is free software; you can redistribute
+ * it and/or modify it under the terms of the GNU General
+ * Public License as published by the Free Software
+ * Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied
+ * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more
+ * details.
+ * 
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place,
+ * Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/sched.h>
+#include <asm/uaccess.h>
+
+
+#define MODULE_VERSION "1.0"
+#define MODULE_NAME "procfs_example"
+
+#define FOOBAR_LEN 8
+
+struct fb_data_t {
+	char name[FOOBAR_LEN + 1];
+	char value[FOOBAR_LEN + 1];
+};
+
+
+static struct proc_dir_entry *example_dir, *foo_file,
+	*bar_file, *jiffies_file, *tty_device, *symlink;
+
+
+struct fb_data_t foo_data, bar_data;
+
+
+static int proc_read_jiffies(char *page, char **start,
+			     off_t off, int count,
+			     int *eof, void *data)
+{
+	int len;
+
+	MOD_INC_USE_COUNT;
+	
+	len = sprintf(page, "jiffies = %ld\n",
+                      jiffies);
+
+	MOD_DEC_USE_COUNT;
+
+	return len;
+}
+
+
+static int proc_read_foobar(char *page, char **start,
+			    off_t off, int count, 
+			    int *eof, void *data)
+{
+	int len;
+	struct fb_data_t *fb_data = (struct fb_data_t *)data;
+
+	MOD_INC_USE_COUNT;
+	
+	len = sprintf(page, "%s = '%s'\n", 
+		      fb_data->name, fb_data->value);
+
+	MOD_DEC_USE_COUNT;
+
+	return len;
+}
+
+
+static int proc_write_foobar(struct file *file,
+			     const char *buffer,
+			     unsigned long count, 
+			     void *data)
+{
+	int len;
+	struct fb_data_t *fb_data = (struct fb_data_t *)data;
+
+	MOD_INC_USE_COUNT;
+
+	if(count > FOOBAR_LEN)
+		len = FOOBAR_LEN;
+	else
+		len = count;
+
+	if(copy_from_user(fb_data->value, buffer, len)) {
+		MOD_DEC_USE_COUNT;
+		return -EFAULT;
+	}
+
+	fb_data->value[len] = '\0';
+
+	MOD_DEC_USE_COUNT;
+
+	return len;
+}
+
+
+static int __init init_procfs_example(void)
+{
+	int rv = 0;
+
+	/* create directory */
+	example_dir = proc_mkdir(MODULE_NAME, NULL);
+	if(example_dir == NULL) {
+		rv = -ENOMEM;
+		goto out;
+	}
+	
+	example_dir->owner = THIS_MODULE;
+	
+	/* create jiffies using convenience function */
+	jiffies_file = create_proc_read_entry("jiffies", 
+					      0444, example_dir, 
+					      proc_read_jiffies,
+					      NULL);
+	if(jiffies_file == NULL) {
+		rv  = -ENOMEM;
+		goto no_jiffies;
+	}
+
+	jiffies_file->owner = THIS_MODULE;
+
+	/* create foo and bar files using same callback functions */
+	foo_file = create_proc_entry("foo", 0644, example_dir);
+	if(foo_file == NULL) {
+		rv = -ENOMEM;
+		goto no_foo;
+	}
+
+	strcpy(foo_data.name, "foo");
+	strcpy(foo_data.value, "foo");
+	foo_file->data = &foo_data;
+	foo_file->read_proc = proc_read_foobar;
+	foo_file->write_proc = proc_write_foobar;
+	foo_file->owner = THIS_MODULE;
+		
+	bar_file = create_proc_entry("bar", 0644, example_dir);
+	if(bar_file == NULL) {
+		rv = -ENOMEM;
+		goto no_bar;
+	}
+
+	strcpy(bar_data.name, "bar");
+	strcpy(bar_data.value, "bar");
+	bar_file->data = &bar_data;
+	bar_file->read_proc = proc_read_foobar;
+	bar_file->write_proc = proc_write_foobar;
+	bar_file->owner = THIS_MODULE;
+		
+	/* create tty device */
+	tty_device = proc_mknod("tty", S_IFCHR | 0666,
+				example_dir, MKDEV(5, 0));
+	if(tty_device == NULL) {
+		rv = -ENOMEM;
+		goto no_tty;
+	}
+	
+	tty_device->owner = THIS_MODULE;
+
+	/* create symlink */
+	symlink = proc_symlink("jiffies_too", example_dir, 
+			       "jiffies");
+	if(symlink == NULL) {
+		rv = -ENOMEM;
+		goto no_symlink;
+	}
+
+	symlink->owner = THIS_MODULE;
+
+	/* everything OK */
+	printk(KERN_INFO "%s %s initialised\n",
+	       MODULE_NAME, MODULE_VERSION);
+	return 0;
+
+no_symlink:
+	remove_proc_entry("tty", example_dir);
+no_tty:
+	remove_proc_entry("bar", example_dir);
+no_bar:
+	remove_proc_entry("foo", example_dir);
+no_foo:
+	remove_proc_entry("jiffies", example_dir);
+no_jiffies:			      
+	remove_proc_entry(MODULE_NAME, NULL);
+out:
+	return rv;
+}
+
+
+static void __exit cleanup_procfs_example(void)
+{
+	remove_proc_entry("jiffies_too", example_dir);
+	remove_proc_entry("tty", example_dir);
+	remove_proc_entry("bar", example_dir);
+	remove_proc_entry("foo", example_dir);
+	remove_proc_entry("jiffies", example_dir);
+	remove_proc_entry(MODULE_NAME, NULL);
+
+	printk(KERN_INFO "%s %s removed\n",
+	       MODULE_NAME, MODULE_VERSION);
+}
+
+
+module_init(init_procfs_example);
+module_exit(cleanup_procfs_example);
+
+MODULE_AUTHOR("Erik Mouw");
+MODULE_DESCRIPTION("procfs examples");
+
+EXPORT_NO_SYMBOLS;


